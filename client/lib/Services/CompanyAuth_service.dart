import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:client/Models/server.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyAuth {
  static Future<String> signinCompService(name) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;
  
    String apiUrl = '$URL_SIGNINCOMPANY';
    http.Response response = await http.post(apiUrl,
        body: {'name': name}, headers: {'Authorization': 'Bearer$token'});
      var jsonResponseToken = json.decode(response.body);
      prefs.setString("token", jsonResponseToken['token']);
    return ("${response.statusCode}");
  }
}

