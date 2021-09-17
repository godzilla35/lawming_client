import 'package:flutter/material.dart';
import 'package:client/models/user_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Email :'),
                  Expanded(
                    child: TextField(
                      controller: emailController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Password :'),
                  Expanded(
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      print('login button clicked');
                      bool res = await Provider.of<UserModel>(context, listen: false)
                          .logIn(emailController.text, passwordController.text);
                      if(res) {
                        Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (Route<dynamic> route) => false);
                      } else {
                        print('login failed!');
                      }

                    },
                    child: Text('login'),
                  ),
                  TextButton(
                    onPressed: () {
                      print('sigin button clicked');
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: Text('signin'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
