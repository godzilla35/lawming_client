import 'package:flutter/material.dart';
import 'constant.dart';
import 'content.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Content(title: '복대리', location: '대구지방법원', date: "2021-09-12", cost: "1000",),
        Content(title: '복대리', location: '서울지방법원', date: "2021-09-12", cost: "2000",),
      ],
    );
  }
}
