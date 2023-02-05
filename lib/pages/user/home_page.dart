import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/Services/auth_service.dart';
import 'package:lapor_in/pages/auth/auth_page.dart';

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
    Navigator.pushReplacementNamed(context, AuthPage.routesName);
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('this is homepage'),
            IconButton(onPressed: userSignOut, icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
