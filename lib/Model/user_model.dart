import 'package:flutter/cupertino.dart';
import '../networkHelper.dart';


class UserModel extends ChangeNotifier {
  String? userEmail = 'no-email';
  String? userPassword = 'null';
  String? userNick = 'no-email';
  String? userJwt = 'no-email';
  //User _user = User();

  Future<bool> login(String email, String password) async {
    userEmail = email;
    userPassword = password;

    NetworkHelper auth = NetworkHelper();

    bool res = await auth.logIn(userEmail!, userPassword!);

    notifyListeners();

    return res;
  }
}
