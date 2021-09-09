import 'package:flutter/material.dart';

class Content extends StatelessWidget {

  Content({this.title, this.location, this.date, this.cost});

  final title;
  final location;
  final date;
  final cost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
      child: OutlinedButton(
        child: Column(
          children: [
            Text('제목 : $title'),
            Text('장소 : $location'),
            Text('날짜 : $date'),
            Text('희망 비용 : $cost원'),
          ],
        ),
        onPressed: () {
          print('test1 clicked');
        },
      ),
    );
  }
}
