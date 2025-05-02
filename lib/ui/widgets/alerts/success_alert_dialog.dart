import 'package:flutter/material.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String message;

  SuccessAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Success'),
      content: Text(message),
      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Text('OK'),
      //   ),
      // ],
    );
  }
}
