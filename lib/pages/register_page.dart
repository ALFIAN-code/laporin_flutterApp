import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../component/error_dialog.dart';
import '../component/my_button.dart';
import '../component/text_field.dart';
import '../style.dart';
import '../component/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  static String routesName = '/register';
  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController =
  //     TextEditingController();
  // final Key _emailFormKey = GlobalKey<FormState>();
  // final Key _passwordFormKey = GlobalKey<FormState>();

  bool _hidePassword = true;
  // bool _hideConfirmPassword = true;

  void userRegister() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff8CCD00),
            ),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

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
            title: 'email cannot be empty', content: '', context: context);
      } else if (_passwordController.text.isEmpty) {
        errorDialog(
            title: 'password cannot be empty', content: '', context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFFB247),
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100)),
                      gradient: LinearGradient(
                          colors: [Color(0xffFFB247), Color(0xffFFEBAF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: SvgPicture.asset(
                    'lib/images/user.svg',
                    height: deviceHeight * 0.2,
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
                    'Register',
                    style: bold40.copyWith(
                      color: const Color(0xff575151),
                    ),
                  ),
                ),
                //username field
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                  // formKey: _emailFormKey,
                  hint: 'Email',
                  obsecureText: false,
                  controller: _emailController,
                ),

                //password field
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                    // formKey: _passwordFormKey,
                    hint: 'Password',
                    obsecureText: _hidePassword,
                    controller: _passwordController,
                    suffix: IconButton(
                      icon: (_hidePassword)
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    )),
                // MyTextField(
                //     hint: 'Confirm Password',
                //     obsecureText: _hideConfirmPassword,
                //     controller: _confirmPasswordController,
                //     suffix: IconButton(
                //       icon: (_hideConfirmPassword)
                //           ? const Icon(Icons.visibility)
                //           : const Icon(Icons.visibility_off),
                //       onPressed: () {
                //         setState(() {
                //           _hideConfirmPassword = !_hideConfirmPassword;
                //         });
                //       },
                //     )),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                //sign in button
                MyButton(
                  onTap: userRegister,
                  color: const Color(0xffFF8515),
                  child: Text(
                    'Register',
                    style: bold17.copyWith(color: Colors.white),
                  ),
                ),
                //dont have an account? register
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('have an account? ',
                        style: medium15.copyWith(
                          color: Colors.grey[600],
                        )),
                    TextButton(
                        onPressed: widget.onTap,
                        // () {
                        //   // Navigator.pushReplacementNamed(
                        //   //     context, LoginPage.routesName);

                        // },
                        child: Text(
                          'sign in',
                          style: medium15,
                        )),
                  ],
                ),
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
                        child: Text('Atau login dengan',
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
                  height: deviceHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'lib/images/google.png',
                      onTap: () {
                        print('tap tap tap');
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SquareTile(
                      imagePath: 'lib/images/facebook.png',
                      onTap: () {
                        print('tap tap tap');
                      },
                    )
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
