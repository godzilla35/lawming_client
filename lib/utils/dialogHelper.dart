import 'package:flutter/material.dart';

class DialogHelper {
  void ShowErrorDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ));
  }
}