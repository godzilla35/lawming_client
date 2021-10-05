import 'package:client/screens/post_screens/post_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/models/bokdaeriPost.dart';

class Content extends StatelessWidget {

  Content({required this.title, required this.bokPost, required this.myUploadingPost});

  final title;
  final BokdaeriPost bokPost;
  bool myUploadingPost = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
      child: OutlinedButton(
        child: Column(
          children: [
            Text('제목 : $title'),
            Text('장소 : ${bokPost.court}'),
            Text('날짜 : ${bokPost.time}'),
            Text('희망 비용 : ${bokPost.cost}원'),
          ],
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => PostViewScreen(bokdaeriPost: bokPost, myPost: myUploadingPost,)));
        },
      ),
    );
  }
}
