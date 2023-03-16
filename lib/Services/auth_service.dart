import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lapor_in/auth_page.dart';
import '../component/error_dialog.dart';
import '../component/utils.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  var navigatorkey = GlobalKey<NavigatorState>();

  Future signInWithGoogle(BuildContext context) async {
    try {
      final googleUser = await googleSignIn
          .signIn()
          .catchError((onError) => Utils.showSnackBar(onError));
      _user = googleUser;

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on PlatformException catch (e) {
      if (e.code.contains("sign_in_canceled")) {
        Navigator.pushReplacementNamed(context, AuthPage.routesName);
      }
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
