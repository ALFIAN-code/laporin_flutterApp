import 'package:flutter/material.dart';

class Utils {
  static var messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String text) {
    if (text.isEmpty) return;

    final snackBar = SnackBar(content: Text(text));

    messengerKey.currentState!.removeCurrentSnackBar();
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
