import 'package:flutter/material.dart';

class utils {
  static var messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text));

    messengerKey.currentState!.removeCurrentSnackBar();
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
