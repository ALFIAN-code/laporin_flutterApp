import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/pages/auth/desktop/register_page_desktop.dart';
import 'package:lapor_in/pages/auth/mobile/register_page_mobile.dart';
import '../../../component/error_dialog.dart';
import '../responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  static String routesName = '/register';
  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var navigatorkey = GlobalKey<NavigatorState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  // final TextEditingController _confirmPasswordController =
  //     TextEditingController();
  // final Key _emailFormKey = GlobalKey<FormState>();
  // final Key _passwordFormKey = GlobalKey<FormState>();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  //function for add details info to database
  postDetailsToFirestore(
      {required String email,
      required String role,
      required String password,
      required String fullname}) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'fullname': fullname,
      'email': email,
      'password': password,
      'uid': user.uid,
      'role': role,
      'is_data_complete': false
    });
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //function for user register and add details using postDetailsToFirestore
  void userRegister() async {
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
      if (passwordConfirm()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) => postDetailsToFirestore(
                  email: _emailController.text,
                  fullname: _fullnameController.text,
                  password: _passwordController.text,
                  role: 'user',
                ));
      }

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // navigatorkey.currentState!.pop();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // navigatorkey.currentState!.pop();
      if (e.code == 'email-already-in-use') {
        errorDialog(
            title: 'email already in use',
            content: e.message.toString(),
            context: context);
      } else if (e.code == 'invalid-email') {
        errorDialog(
            title: 'invalid email',
            content: e.message.toString(),
            context: context);
      } else if (e.code == 'weak-password') {
        errorDialog(
            title: 'weak password',
            content: e.message.toString(),
            context: context);
      } else if (_emailController.text.isEmpty) {
        errorDialog(
            title: 'email field cannot be empty',
            content: '',
            context: context);
      } else if (_passwordController.text.isEmpty) {
        errorDialog(
            title: 'password field cannot be empty',
            content: '',
            context: context);
      }
    }
  }

  //function for confirm user password
  bool passwordConfirm() {
    if (_passwordController.text == _passwordConfirmController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScafold: RegisterPageMobile(
            emailController: _emailController,
            hidePassword: _hidePassword,
            passwordController: _passwordController,
            onTap: widget.onTap,
            fullnameController: _fullnameController,
            hideConfirmPassword: _hideConfirmPassword,
            passwordConfirmController: _passwordConfirmController,
            userRegister: userRegister),
        tabletScafold: RegisterPageMobile(
            emailController: _emailController,
            hidePassword: _hidePassword,
            passwordController: _passwordController,
            onTap: widget.onTap,
            fullnameController: _fullnameController,
            hideConfirmPassword: _hideConfirmPassword,
            passwordConfirmController: _passwordConfirmController,
            userRegister: userRegister),
        desktopScafold: RegisterPageDesktop(
            emailController: _emailController,
            hidePassword: _hidePassword,
            passwordController: _passwordController,
            onTap: widget.onTap,
            fullnameController: _fullnameController,
            hideConfirmPassword: _hideConfirmPassword,
            passwordConfirmController: _passwordConfirmController,
            userRegister: userRegister));
  }
}
