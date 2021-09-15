import 'package:flutter/cupertino.dart';
import '../networkHelper.dart';
import 'package:client/user.dart';


class UserModel extends ChangeNotifier {
  String? userEmail = 'no-email';
  String? userPassword = 'null';
  String? userNick = 'no-email';
  String? userJwt = 'no-email';
  //User _user = User();

  Future<bool> login(String email, String password) async {


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
}
