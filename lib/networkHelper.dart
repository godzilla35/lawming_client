import 'dart:convert';
import 'package:client/Model/bokdaeriPost.dart';

import 'constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class NetworkHelper {
  NetworkHelper();

  Future<User?> logIn(String ID, String Password) async {
    if (ID == null || Password == null) return null;

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
        return null;
      }

      Map<String, dynamic> postResJson = jsonDecode(postRes.body);
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(postResJson['token']);

      // decodedToken["id"]; decodedToken["email"]; decodedToken["nick"];
      User loginUser = User(
          email: decodedToken["email"],
          nick: decodedToken["nick"],
          jwt: postResJson['token']);

      print(loginUser);

      final prefs = await SharedPreferences.getInstance();
      bool res = await prefs.setString('loggedID', ID);

      if (res == false) {
        print('refs.setString ID failed');
      }

      res = await prefs.setString('loggedPassword', Password);
      if (res == false) {
        print('refs.setString password failed');
      }

      return loginUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> bokdaeriPosting(String userJWT, BokdaeriPost bok) async {
    try {
      final postRes = await http.post(
        Uri.parse(bokdaeriPostAPIUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userJWT}',
        },
        body: jsonEncode(<String, String>{
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
