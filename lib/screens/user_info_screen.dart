import 'package:client/screens/post_screens/my_apply_posts_screen.dart';
import 'package:client/screens/post_screens/my_uploading_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/constants/constant.dart';
import 'package:client/widgets/content.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
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
            TextButton(
                onPressed: () {
                  print('logout clicked!');
                  Provider.of<UserModel>(context, listen: false).logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (Route<dynamic> route) => false);
                },
                child: Text('logout'))
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
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyUploadingPostsScreen()));
                },
                child: Text('내가 올린 복대리')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApplyPostsScreen()));
                },
                child: Text('내가 신청한 복대리')),
          ],
        ),
      ],
    );
  }
}
