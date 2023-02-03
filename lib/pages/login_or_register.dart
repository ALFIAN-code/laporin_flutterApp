// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:lapor_in/pages/login_page.dart';
import 'package:lapor_in/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  LoginOrRegister({super.key});

  String routesName = '/loginOrRegister';

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
