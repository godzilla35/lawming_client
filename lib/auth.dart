import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth {
  Auth({this.ID, this.Password});

  String? ID;
  String? Password;

  Future<bool> logIn() async {
    if (ID == null || Password == null) return false;

    try {
      final postRes = await http.post(
        Uri.parse('http://3.15.146.212:8080/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': ID!,
          'password': Password!,
        }),
      );


      if(postRes.statusCode != 200) {
        print('login failed ${postRes.body}');
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      bool res = await prefs.setString('loggedID', ID!);

      if (res == false) {
        print('refs.setString ID failed');
        return false;
      }

      res = await prefs.setString('loggedPassword', Password!);
      if (res == false) {
        print('refs.setString password failed');
        return false;
      }

      return (postRes.statusCode == 200);

    } catch (e) {
      print(e);
      return false;
    }
  }
}
