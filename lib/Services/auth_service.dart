import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../component/error_dialog.dart';
import '../component/utils.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  var navigatorkey = GlobalKey<NavigatorState>();

  Future signInWithGoogle(BuildContext context) async {
    try {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: RefreshProgressIndicator(
                color: Color(0xff8CCD00),
              ),
            );
          });

      final googleUser = await googleSignIn
          .signIn()
          .catchError((onError) => Utils.showSnackBar(onError));
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      errorDialog(
          title: e.code, content: e.message.toString(), context: context);
      // print(e.message as String);
    }
  }

  void googleLogout() async {
    var hasInternet = await InternetConnectionCheckerPlus().hasConnection;
    if (await googleSignIn.isSignedIn()) {
      if (hasInternet) {
        await googleSignIn.disconnect();
      } else {
        Utils.showSnackBar('yahhh gak ada internet');
      }
    }
  }
}
