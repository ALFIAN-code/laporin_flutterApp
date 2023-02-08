import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lapor_in/Services/auth_service.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/component/square_tile.dart';
import 'package:lapor_in/component/text_field.dart';
import 'package:lapor_in/component/utils.dart';
import 'package:lapor_in/pages/theme/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../component/error_dialog.dart';
import 'forgot_password_page.dart';

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

  bool _hidePassword = true;
  // final Key _emailFormKey = GlobalKey<FormState>();
  // final Key _passwordFormKey = GlobalKey<FormState>();
  var hasConnection = InternetConnectionChecker().hasConnection;

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
          password: _passwordController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
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
      } else if (await hasConnection) {
        Utils.showSnackBar('tidak ada internet');
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
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Color(0xffADFAC2)),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Hero(
                  tag: 'leading',
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(100)),
                        gradient: LinearGradient(
                            colors: [Color(0xffADFAC2), Color(0xff7DFFFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: SvgPicture.asset(
                      'lib/images/user.svg',
                      height: deviceHeight * 0.2,
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  width: double.infinity,
                  child: Text(
                    'Sign in',
                    style: bold40.copyWith(color: const Color(0xff575151)),
                  ),
                ),
                //username field
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                  textCapitalization: TextCapitalization.none,
                  hint: 'Email',
                  obsecureText: false,
                  controller: _emailController,
                ),

                //password field
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                    textCapitalization: TextCapitalization.none,
                    hint: 'Password',
                    obsecureText: _hidePassword,
                    controller: _passwordController,
                    suffix: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: (_hidePassword)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.005,
                          horizontal: deviceWidth * 0.08),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPasswordPage.routesName);
                        },
                        child: Text('Forgot Password?',
                            style: regular15.copyWith(
                              color: Colors.grey[600],
                            )),
                      ),
                    ),
                  ],
                ),
                //sign in button
                Hero(
                  tag: 'button',
                  child: MyButton(
                    onTap: userSignIn,
                    color: const Color(0xff8CCD00),
                    child: Text(
                      'Sign in',
                      style: bold17.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                //dont have an account? register
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account? ',
                        style: medium15.copyWith(
                          color: Colors.grey[600],
                        )),
                    TextButton(
                        onPressed: widget.onTap,
                        child: Text(
                          'Register',
                          style: medium15,
                        )),
                  ],
                ),
                //or sign in with
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Or Login With',
                            style:
                                semiBold15.copyWith(color: Colors.grey[700])),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),
                ),
                //google & facebook icon
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      title: 'Google',
                      imagePath: 'lib/images/google.png',
                      onTap: () {
                        AuthService().signInWithGoogle(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
