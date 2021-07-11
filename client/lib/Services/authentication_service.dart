import 'dart:convert';
import 'package:client/Models/server.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<String> signupService(name, email, phone, password) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    String apiUrl = '$URL_SIGNUPUSER';
    http.Response response = await http.post(apiUrl, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': 'user'
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    return ("${response.statusCode}");
  }

  static Future<String> signInService(phone, password) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;
    String apiUrl = '$URL_SIGNINUSER';
  

    http.Response response = await http.post(apiUrl,
        body: {'phone': phone, 'password': password},
        headers: {'Authorization': 'Bearer$token'});
    var jsonResponseToken = json.decode(response.body); 
    jsonResponseToken = prefs?.setString("token", jsonResponseToken['token']);
    return ("${response.statusCode}");
  }
}
