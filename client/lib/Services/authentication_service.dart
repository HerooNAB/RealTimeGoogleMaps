import 'dart:convert';

import 'package:client/Models/company_model.dart';
import 'package:client/Models/server.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

//import 'package:shared_preferences/shared_preferences.dart';


class AuthService{
  static Future<Company> signupService(name, email, phone, password) async {
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
    }, headers: {'Authorization': 'Bearer $token'});
    
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
    } else {
      print('dang ky that bai');
    }
    return null;
  }

  static Future<Company> signInService(phone, password) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;
    String apiUrl = '$URL_SIGNINUSER';
   
    http.Response response =
        await http.post(apiUrl, body: {'phone': phone, 'password': password}, 
        headers: {'Authorization': 'Bearer$token'});

    if(response.statusCode == 200) {
      var jsonResponseToken = json.decode(response.body);
      prefs.setString("token", jsonResponseToken['token']);
      print('danh nhap thanh cong');
      print(jsonResponseToken);
      print("Result: ${response.body}");
      print('dang nhap thanh cong');
    } else {
      print('dang nhap that bai');
    }
    return null;
  }
}