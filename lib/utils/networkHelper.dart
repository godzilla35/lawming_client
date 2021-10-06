import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:client/models/bokdaeriPost.dart';
import 'package:client/constants/constant.dart';
import 'package:client/models/user.dart';


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
      loginUser.id = decodedToken["id"];
      print('userId : ${loginUser.id}');
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
          'state': bok.state.toString(),
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

  Future<List<BokdaeriPost>> getBokPosts(String userJWT) async {
    List<BokdaeriPost> list = List.empty();

    try {
      final getRes = await http.get(
        Uri.parse(bokdaeriGetAPIUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userJWT}',
        },
      );

      if (getRes.statusCode != 200) {
        print('getBokPosts failed ${getRes.body}');
        return List.empty();
      }

      final parsed = json.decode(getRes.body).cast<Map<String, dynamic>>();
      return parsed.map<BokdaeriPost>((json) => BokdaeriPost.fromJson(json)).toList();

    } catch (error) {
      print(error);

      return List.empty();
    }
  }

  Future<bool> joinUser(User user) async {

    try {
      final postRes = await http.post(
        Uri.parse(joinAPIUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': user.email!,
          'nick' : user.nick!,
          'password': user.password!,
          'name': user.name!,
          'phoneNum': user.phoneNum!,
          'officeName': user.officeName!,
          'officeNum': user.officeNum!,
        }),
      );

      if (postRes.statusCode != 200) {
        print('join failed ${postRes.body}');
        return false;
      } else {
        print('===### ${postRes.body}');
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> applyPost(String userJWT, int postID) async {

    try {
      String applyPostURL = '$bokdaeriPostAPIUrl/$postID/apply';

      final result = await http.patch(
        Uri.parse(applyPostURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userJWT}',
        },
      );

      if (result.statusCode != 200) {
        print('applyPost failed ${result.body}');
        return false;
      } else {
        print('applyPost successs ${result.body}');

      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<BokdaeriPost>> getUploadedBokPosts(String userJWT, int userID) async {
    List<BokdaeriPost> list = List.empty();

    try {

      String url = '$bokdaeriGetAPIUrl/$userID';

      final getRes = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userJWT}',
        },
      );

      if (getRes.statusCode != 200) {
        print('getUploadedBokPosts failed ${getRes.body}');
        return List.empty();
      } else {
        print('getUploadedBokPosts success ${getRes.body}');
      }

      final parsed = json.decode(getRes.body).cast<Map<String, dynamic>>();
      return parsed.map<BokdaeriPost>((json) => BokdaeriPost.fromJson(json)).toList();

    } catch (error) {
      print(error);

      return List.empty();
    }
  }

  Future<User?> getPostApplyUsers (String userJWT, int postID) async {

    try {

      String url = '$usersAPIUrl/$postID';

      final getRes = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userJWT}',
        },
      );

      if (getRes.statusCode != 200) {
        print('getUploadedBokPosts failed ${getRes.body}');
        return null;
      } else {
        //print('getUploadedBokPosts success ${getRes.body}');
      }
      var parsedJson = json.decode(getRes.body);

      User user = User(email: parsedJson['email'], jwt: 'null', nick: parsedJson['nick']);
      user.id = parsedJson['id'];
      return user;

    } catch (error) {
      print(error);

      return null;
    }
  }

  Future<bool> setPostState (String userJWT, int postId, PostState postState) async {

    try {

      String url = '$bokdaeriPostStateAPIUrl/$postId/${postState.toString()}';
      print('setPostState $url');
      final res = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userJWT}',
        },
      );

      if (res.statusCode != 200) {
        print('getUploadedBokPosts failed ${res.body}');
        return false;
      } else {
        //print('getUploadedBokPosts success ${getRes.body}');
      }
      var parsedJson = json.decode(res.body);
      print('===### postId : ${parsedJson['PostId']} state : ${parsedJson['state']}');

    } catch (error) {
      print(error);

      return false;
    }

    return true;

  }

}
