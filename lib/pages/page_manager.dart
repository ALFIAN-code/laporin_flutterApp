import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/component/utils.dart';

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

  @override
  void initState() {
    userData.get(uid);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
