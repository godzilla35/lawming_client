import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/constants/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool logOut() {

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('email : '),
            Text(
              '${Provider.of<UserModel>(context, listen: false).userEmail!}',
              //style: kOptionStyle,
            ),
            TextButton(onPressed: () {
              print('logout clicked!');
              Provider.of<UserModel>(context, listen: false).logOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
            }, child: Text('logout'))
          ],
        ),
        Row(
          children: [
            Text('nick : '),
            Text(
              '${Provider.of<UserModel>(context, listen: false).userNick!}',
              //style: kOptionStyle,
            ),
          ],
        ),
      ],
    );
  }
}
