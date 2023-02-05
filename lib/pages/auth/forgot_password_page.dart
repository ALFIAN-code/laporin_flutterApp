import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/pages/theme/style.dart';

import '../../component/my_button.dart';
import '../../component/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static String routesName = '/forgotPassword';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailControler = TextEditingController();

  bool canResentEmail = true;

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailControler.text.trim());

      // Navigator.pop(context);
      // ignore: use_build_context_synchronously
      errorDialog(
          title: 'password reset email sent',
          content:
              'try check your email, then click link to reset your password',
          context: context);

      setState(() => canResentEmail = false);
      await Future.delayed(const Duration(seconds: 60));
      setState(() => canResentEmail = true);

      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      // Navigator.pop(context);
      errorDialog(
          title: e.code, content: e.message.toString(), context: context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text(
          'back',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Row(
              //       children: [
              //         const Padding(
              //           padding: EdgeInsets.all(10.0),
              //           child: Icon(Icons.arrow_back),
              //         ),
              //         Text(
              //           "back",
              //           style: semiBold17,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Image.asset(
                'lib/images/forgot_password.jpg',
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              const SizedBox(
                height: 30,
              ),
              Text('Forgot Password',
                  style: bold25.copyWith(color: const Color(0xff575151))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                    'We will send a link to your email to reset your password',
                    textAlign: TextAlign.center,
                    style: regular15.copyWith(color: const Color(0xff575151))),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  textCapitalization: TextCapitalization.none,
                  controller: _emailControler,
                  hint: 'example@mail.com',
                  obsecureText: false),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: () {
                  if (canResentEmail) {
                    resetPassword();
                  } else {
                    errorDialog(
                        title: 'Email has ben sent',
                        content: 'wait 60 seconds to send again',
                        context: context);
                  }
                },
                color: canResentEmail ? Color(0xffFF8515) : Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Send',
                      style: bold17.copyWith(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
