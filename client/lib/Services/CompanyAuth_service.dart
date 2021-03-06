
import 'package:http/http.dart' as http;
import 'package:client/Models/server.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyAuth{
  static Future<String> signinCompService(name) async {
    final prefs = await SharedPreferences.getInstance();

    String apiUrl = '$URL_SIGNINCOMPANY';
    http.Response response =
        await http.post(apiUrl, body: {
          'name': name}); 
    if(response.statusCode == 200) {
      var jsonResponseToken = json.decode(response.body);
      prefs.setString("token", jsonResponseToken['token']);
      print("Result: ${response.body}");
      print('dang nhap thanh cong');
      print(jsonResponseToken);
    } else {
      print('dang nhap that bai');
    }
    return response.body;
  }
}