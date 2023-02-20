// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  final String routesName = '/loginOrRegister';

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPages = true;

  void pagesToggle() {
    setState(() {
      showLoginPages = !showLoginPages;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPages) {
      return LoginPage(onTap: pagesToggle);
    } else {
      return RegisterPage(onTap: pagesToggle);
    }
  }
}
