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
}

class UserData {
  String role = '';
  String fullname = '';
  String alamat = '';
  int nik = 0;
  String email = '';
  int telp = 0;
  String uid = '';

  Future get(String? uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        role = document.get('role');
        fullname = document.get('fullname');
        alamat = document.get('alamat');
        nik = document.get('nik');
        email = document.get('email');
        telp = document.get('telp');
        uid = document.get('uid');
      } else {
        print('user tidak ditemukan');
      }
    });
  }
}
