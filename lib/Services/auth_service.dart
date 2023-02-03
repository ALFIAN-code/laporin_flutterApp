import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future signInWithGoogle() async {
    // ignore: avoid_print
    final googleUser =
        await googleSignIn.signIn().catchError((onError) => print(onError));
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) => print(onError));

    ChangeNotifier();
  }

  googleLogout() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }
  }
}
