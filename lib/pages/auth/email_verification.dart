import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/component/snackbar.dart';
import 'package:lapor_in/pages/page_manager.dart';
import 'package:lapor_in/pages/theme/style.dart';
import 'package:lapor_in/pages/user/home_page.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResentEmail = false;

  bool userPage = false;
  bool adminPage = false;
  bool petugasPage = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (timer) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResentEmail = false);
      await Future.delayed(const Duration(seconds: 60));
      setState(() => canResentEmail = true);
    } catch (e) {
      utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return const PageManager();
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: AppBar(
                elevation: 0.0,
                systemOverlayStyle:
                    const SystemUiOverlayStyle(statusBarColor: Colors.white),
              )),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/email_verification.jpg',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('Verify Email',
                    style: bold25.copyWith(color: const Color(0xff575151))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text('A verification email has ben sent to your email',
                      textAlign: TextAlign.center,
                      style:
                          regular15.copyWith(color: const Color(0xff575151))),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onTap: () {
                    if (canResentEmail) {
                      sendVerificationEmail();
                    } else {
                      errorDialog(
                          title: 'Email has ben sent',
                          content: 'wait 60 seconds to send again',
                          context: context);
                    }
                  },
                  color:
                      (canResentEmail) ? const Color(0xff8CCD00) : Colors.grey,
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
                        'Resent Email',
                        style: bold17.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('cancel'))
              ],
            ),
          ),
        ),
      );
    }
  }
}