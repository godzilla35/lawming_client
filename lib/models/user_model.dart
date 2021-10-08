import 'package:flutter/cupertino.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:client/models/user.dart';
import 'package:client/constants/constant.dart';


class UserModel extends ChangeNotifier {
  String? userEmail = NULL;
  String? userPassword = NULL;
  String? userNick = NULL;
  String? userJwt = NULL;
  int userID = 0;
  String? userName = '';
  String? userPhoneNum = '';
  String? userOfficeName = '';
  String? userOfficeNum = '';


  Future<bool> logIn(String email, String password) async {


    NetworkHelper auth = NetworkHelper();

    User? user = await auth.logIn(email, password);

    if(user != null) {
      userEmail = user.email;
      userNick = user.nick;
      userJwt = user.jwt;
      userID = user.id!;

      userName = user.name;
      userPhoneNum = user.phoneNum;
      userOfficeName = user.officeName;
      userOfficeNum = user.officeNum;
    }


    notifyListeners();

    return (user != null);
  }

  bool logOut () {
    userEmail = NULL;
    userNick = NULL;
    userJwt = NULL;
    userID = 0;

    return true;
  }
}
