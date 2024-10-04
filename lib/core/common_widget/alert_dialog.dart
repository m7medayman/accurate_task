import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String content, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Add functionality for the "OK" button
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
