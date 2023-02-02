import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/Services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static String routesName = '/homepage';

  void userSignOut() {
    AuthService().googleLogout();
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser;

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
