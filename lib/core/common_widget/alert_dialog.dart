import 'package:accurate_task/core/theme/color_manager.dart';
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

void showLoadingState(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("loading"),
        content: CircularProgressIndicator(
          strokeWidth: 10,
          color: ColorManager.primaryColor,
        ),
      );
    },
  );
}
