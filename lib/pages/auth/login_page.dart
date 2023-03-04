import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lapor_in/pages/auth/desktop/login_page_desktop.dart';
import 'package:lapor_in/pages/auth/mobile/login_page_mobile.dart';
import 'package:lapor_in/pages/responsive_layout.dart';
import '../../../component/error_dialog.dart';
import '../../../component/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});

  static String routesName = '/login';
  final void Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var navigatorkey = GlobalKey<NavigatorState>();

  final bool _hidePassword = true;
  bool hasInternet = true;

  @override
  void initState() {
    hasInternet = Utils.isConnected();
    super.initState();
  }

  void userSignIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: RefreshProgressIndicator(
              color: Color(0xff8CCD00),
            ),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pop(context);
      // if (mounted) {

      // }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        errorDialog(
            title: 'user not found',
            content: e.message.toString(),
            context: context);
      } else if (e.code == 'invalid-email') {
        errorDialog(
            title: 'wrong password',
            content: e.message.toString(),
            context: context);
      } else if (e.code == 'wrong-password') {
        errorDialog(
            title: 'wrong password',
            content: e.message.toString(),
            context: context);
      } else if (_emailController.text.isEmpty) {
        errorDialog(
            title: 'email cannot be empty', content: '', context: context);
      } else if (_passwordController.text.isEmpty) {
        errorDialog(
            title: 'password cannot be empty', content: '', context: context);
      } else {
        errorDialog(
            title: e.code, content: e.message.toString(), context: context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScafold: LoginPageMobile(
            userSignIn: userSignIn,
            emailController: _emailController,
            hidePassword: _hidePassword,
            passwordController: _passwordController,
            onTap: widget.onTap),
        tabletScafold: LoginPageMobile(
            userSignIn: userSignIn,
            emailController: _emailController,
            hidePassword: _hidePassword,
            passwordController: _passwordController,
            onTap: widget.onTap),
        desktopScafold: LoginScreenDesktop(
            userSignIn: userSignIn,
            emailController: _emailController,
            hidePassword: _hidePassword,
            passwordController: _passwordController,
            onTap: widget.onTap));
  }
}
