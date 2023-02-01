import 'package:flutter/material.dart';

void errorDialog(
    {required String title,
    required String content,
    required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          title: Text(title),
        );
      });
}
