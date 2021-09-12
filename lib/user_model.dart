import 'package:flutter/cupertino.dart';
import 'auth.dart';

import 'user.dart';

class UserModel extends ChangeNotifier {
  String? userEmail = 'no-email';
  String? userPassword = 'null';
  String? userNick = 'no-email';
  String? userJwt = 'no-email';
  //User _user = User();

  Future<bool> login(String email, String password) async {
    userEmail = email;
    userPassword = password;

    Auth auth = Auth(ID: userEmail, Password: userPassword);

    bool res = await auth.logIn();

    notifyListeners();

    return res;
  }
}
