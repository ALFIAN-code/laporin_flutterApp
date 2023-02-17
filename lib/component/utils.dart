import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../Services/auth_service.dart';

class Utils {
  static var messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String text) {
    if (text.isEmpty) return;

    final snackBar = SnackBar(content: Text(text));

    messengerKey.currentState!.removeCurrentSnackBar();
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static bool isConnected() {
    bool connected = false;
    InternetConnectionCheckerPlus.createInstance()
        .onStatusChange
        .listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        connected = false;
      } else if (status == InternetConnectionStatus.connected) {
        connected = true;
      }
    });
    return connected;
  }

  static void userSignOut(BuildContext context) {
    AuthService().googleLogout();
    FirebaseAuth.instance.signOut();
  }

  static Future<String> getUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot document) {
      String status = '';
      if (document.exists) {
        if (document.get('role') == "admin") {
          status = 'admin';
        } else if (document.get('role') == "petugas") {
          status = 'petugas';
        } else if (document.get('role') == "user") {
          status = 'user';
        } else {
          status = 'error';
        }
      } else {
        print('user tidak ditemukan');
      }
      return status;
    });
  }
}
