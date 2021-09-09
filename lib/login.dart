import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'auth.dart';



class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    Auth auth = Auth(ID: data.name, Password: data.password);
    bool logInRes = await auth.logIn();

    return (logInRes == false ? 'login-failed!' : '');

    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return '';
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'LAWMING',
      logo: 'images/test.jpg',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (Route<dynamic> route) => false);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}