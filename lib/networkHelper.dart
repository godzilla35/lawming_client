import 'dart:convert';
import 'package:client/Model/bokdaeriPost.dart';

import 'constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class NetworkHelper {
  NetworkHelper();

  Future<bool> logIn(String ID, String Password) async {
    if (ID == null || Password == null) return false;

    try {
      final postRes = await http.post(
        Uri.parse(loginAPIUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': ID,
          'password': Password,
        }),
      );

      if (postRes.statusCode != 200) {
        print('login failed ${postRes.body}');
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      bool res = await prefs.setString('loggedID', ID);

      if (res == false) {
        print('refs.setString ID failed');
        return false;
      }

      res = await prefs.setString('loggedPassword', Password);
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

  Future<bool> bokdaeriPosting(String userEmail, BokdaeriPost bok) async {
    try {
      final postRes = await http.post(
        Uri.parse(bokdaeriPostAPIUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': userEmail!,
          'court': bok.court,
          'time': bok.time.toString(),
          'progressType': bok.progressType.toString(),
          'myPartyType': bok.myPartyType.toString(),
          'myName': bok.myName,
          'otherPartyType': bok.otherPartyType.toString(),
          'opponentName': bok.opponentName,
          'caseNum': bok.caseNum,
          'caseDetail': bok.caseDetail,
          'caseArgument': bok.caseArgument,
          'cost': bok.cost.toString(),
        }),
      );

      if (postRes.statusCode != 200) {
        print('bokdaeriPosting failed ${postRes.body}');
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }

    return true;
  }
}
