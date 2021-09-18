import 'package:client/utils/networkHelper.dart';
import 'package:flutter/material.dart';
import 'package:client/models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:client/utils/dialogHelper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final nickController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    nickController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignIn'),
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
                  Text('nick :'),
                  Expanded(
                    child: TextField(
                      controller: nickController,
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
                  Text('Re-Password :'),
                  Expanded(
                    child: TextField(
                      controller: rePasswordController,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {

                      if(EmailValidator.validate(emailController.text) == false) {
                        DialogHelper().ShowErrorDialog(context, 'error', 'invalid email');
                        return;
                      }

                      if(nickController.text.isEmpty) {
                        DialogHelper().ShowErrorDialog(context, 'error', 'empty nick');
                        return;
                      }

                      if (rePasswordController.text !=
                          passwordController.text) {
                        DialogHelper().ShowErrorDialog(context, 'error', 'password not matched!');
                        return;
                      }

                      NetworkHelper nw = NetworkHelper();

                      User joinUser = User();
                      joinUser.email = emailController.text;
                      joinUser.nick = nickController.text;
                      joinUser.password = passwordController.text;

                      bool res = await nw.joinUser(joinUser);

                      if (res) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (Route<dynamic> route) => false);
                      } else {
                        print('join failed!');
                      }
                    },
                    child: Text('submit'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'),
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
