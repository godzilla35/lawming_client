import 'package:flutter/material.dart';
import 'bokdaeriPost.dart';

class Content extends StatelessWidget {

  Content({required this.title, required this.bokPost});

  final title;
  final BokdaeriPost bokPost;

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
          print('content $title clicked');
        },
      ),
    );
  }
}
