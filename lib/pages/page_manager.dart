import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user_model.dart';
import 'admin/dashboard.dart';
import 'user/home_page.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});
  static String routesName = '/pageManager';

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  Timer? timer;
  var uid = FirebaseAuth.instance.currentUser?.uid;
  UserData userData = UserData();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  GoogleSignIn gUser = GoogleSignIn();

  @override
  void initState() {
    isGoogleSignIn();
    userData.get(uid);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> isGoogleSignIn() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (await gUser.isSignedIn()) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.uid)
          .get()
          .then((value) => {
                if (!value.exists)
                  {
                    ref.doc(currentUser?.uid).set({
                      'fullname': currentUser?.displayName,
                      'password' : '-',
                      'email': currentUser?.email,
                      'uid': currentUser?.uid,
                      'role': 'user',
                      'is_data_complete': false
                    })
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userData.get(uid),
        builder: (context, snapshot) {
          if (userData.role.contains('user')) {
            return const HomePage();
          } else if (userData.role.contains('admin') ||
              userData.role.contains('petugas')) {
            return const Dashboard();
          } else {
            return const Text('error');
          }
          // return route;
        },
      ),
    );
  }
}
