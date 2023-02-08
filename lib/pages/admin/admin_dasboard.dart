import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/Services/auth_service.dart';
import 'package:lapor_in/pages/auth/auth_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  static String routesName = '/AdminDashboard';

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
            const Text('this is AdminDashboard'),
            IconButton(onPressed: userSignOut, icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
