import 'package:client/screens/post_screens/post_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/models/bokdaeriPost.dart';

class Content extends StatelessWidget {
  Content(
      {required this.title,
      required this.bokPost,
      required this.myUploadingPost});

  final title;
  final BokdaeriPost bokPost;
  bool myUploadingPost = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '장소 : ${bokPost.court}',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '날짜 : ${bokPost.time}',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '희망 비용 : ${bokPost.cost}원',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => PostViewScreen(
                        bokdaeriPost: bokPost,
                        myPost: myUploadingPost,
                      )));
        },
      ),
    );
  }
}
