import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_or_register.dart';
import 'pages/auth/email_verification.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static String routesName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const EmailVerification();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('data');
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('something went wrong'),
              );
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
