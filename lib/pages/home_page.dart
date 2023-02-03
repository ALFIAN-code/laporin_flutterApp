import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/Services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routesName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void userSignOut() {
    AuthService().googleLogout();

    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser;
  // @override
  // Future<void> initState() async {
  //   super.initState();

  //   await FirebaseFirestore.instance.collection('user').add({
  //     'userID': user?.uid,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('logged in as ${user?.email}'),
            IconButton(onPressed: userSignOut, icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
