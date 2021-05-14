import 'dart:convert';
import 'package:client/Models/user_model.dart';
import 'package:client/Models/server.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class AuthService{
  static Future<String> signupService(name, email, phone, password) async {
    String apiUrl = '$URL_SIGNUP';
    http.Response response = await http.post(apiUrl, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
    } else {
      print('dang ky that bai');
    }
  }

  static Future<String> signInService(phone, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = '$URL_SIGNIN';
   
    http.Response response =
        await http.post(apiUrl, body: {'phone': phone, 'password': password});
    if(response.statusCode == 200) {
      /*var jsonResponseToken = json.decode(response.body);
      prefs.setString("token", jsonResponseToken['token']);
      var jsonResponseId = json.decode(response.body);
      prefs.setString("id", jsonResponseId['_id']);
      print('danh nhap thanh cong');
      print(jsonResponseToken);
      print(jsonResponseId);*/
      print("Result: ${response.body}");
      print('dang nhap thanh cong');
    } else {
      print('dang nhap that bai');
     
    }
  }
}