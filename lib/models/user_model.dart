import 'package:flutter/cupertino.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:client/models/user.dart';
import 'package:client/constants/constant.dart';


class UserModel extends ChangeNotifier {
  String? userEmail = NULL;
  String? userPassword = NULL;
  String? userNick = NULL;
  String? userJwt = NULL;

  Future<bool> logIn(String email, String password) async {


    NetworkHelper auth = NetworkHelper();

    User? user = await auth.logIn(email, password);

    if(user != null) {
      userEmail = user.email;
      userNick = user.nick;
      userJwt = user.jwt;
    }


    notifyListeners();

    return (user != null);
  }

  bool logOut () {
    userEmail = NULL;
    userNick = NULL;
    userJwt = NULL;

    return true;
  }
}
