import 'package:flutter/material.dart';

class MyApplyPostsScreen extends StatefulWidget {
  const MyApplyPostsScreen({Key? key}) : super(key: key);

  @override
  _MyApplyPostsScreenState createState() => _MyApplyPostsScreenState();
}

class _MyApplyPostsScreenState extends State<MyApplyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 신청한 복대리 내역'),
      ),
    );
  }
}
