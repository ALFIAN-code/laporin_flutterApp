import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future signInWithGoogle() async {
    // final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // final credential = GoogleAuthProvider.credential(
    //     accessToken: gAuth.accessToken, idToken: gAuth.accessToken);

    // return await FirebaseAuth.instance.signInWithCredential(credential);

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    ChangeNotifier();
  }

  googleLogout() async {
    await googleSignIn.disconnect();
  }
}
