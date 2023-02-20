import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Services/auth_service.dart';
import '../../../component/my_button.dart';
import '../../../component/square_tile.dart';
import '../../../component/text_field.dart';
import '../../theme/style.dart';
import '../forgot_password_page.dart';

// ignore: must_be_immutable
class LoginPageMobile extends StatefulWidget {
  final TextEditingController emailController;
  bool hidePassword;
  final TextEditingController passwordController;
  final void Function()? userSignIn;
  final void Function()? onTap;

  LoginPageMobile(
      {super.key,
      required this.emailController,
      required this.hidePassword,
      required this.passwordController,
      this.userSignIn,
      this.onTap});

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
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
                Container(
                  height: deviceHeight * 0.25,
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
                  controller: widget.emailController,
                ),

                //password field
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                    textCapitalization: TextCapitalization.none,
                    hint: 'Password',
                    obsecureText: widget.hidePassword,
                    controller: widget.passwordController,
                    suffix: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: (widget.hidePassword)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            widget.hidePassword = !widget.hidePassword;
                          });
                        },
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.symmetric(
                //           vertical: deviceHeight * 0.005,
                //           horizontal: deviceWidth * 0.08),
                //       child: TextButton(
                //         onPressed: () {
                //           Navigator.pushNamed(
                //               context, ForgotPasswordPage.routesName);
                //         },
                //         child: Text('Forgot Password?',
                //             style: regular15.copyWith(
                //               color: Colors.grey[600],
                //             )),
                //       ),
                //     ),
                //   ],
                // ),
                //sign in button
                Hero(
                  tag: 'button',
                  child: MyButton(
                    onTap: widget.userSignIn,
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
