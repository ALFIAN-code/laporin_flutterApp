import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lapor_in/auth_page.dart';

import '../Services/auth_service.dart';

class Utils {
  static var messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String text) {
    if (text.isEmpty) return;

    final snackBar = SnackBar(content: Text(text));

    messengerKey.currentState!.removeCurrentSnackBar();
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static bool isConnected() {
    bool connected = false;
    InternetConnectionCheckerPlus.createInstance()
        .onStatusChange
        .listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        connected = false;
      } else if (status == InternetConnectionStatus.connected) {
        connected = true;
      }
    });
    return connected;
  }

  static void userSignOut(BuildContext context) {
    AuthService().googleLogout();
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AuthPage.routesName);
  }

  static Future<User?> createUser(String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    try {
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Do something with exception. This try/catch is here to make sure
      // that even if the user creation fails, app.delete() runs, if is not,
      // next time Firebase.initializeApp() will fail as the previous one was
      // not deleted.
      print(e.message);
    }

    await app.delete();
    return Future.sync(() => FirebaseAuth.instanceFor(app: app).currentUser);
  }

  static Future<void> deleteUser(
      String uid, String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    try {
      var instance = FirebaseAuth.instanceFor(app: app);
      // deleting user data

      // //deleting user account
      // instance.signInWithEmailAndPassword(email: email, password: password);
      // instance.currentUser!.delete();
      // instance.signOut();

      var user = await instance.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);
      var result = await user.reauthenticateWithCredential(credentials);
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      await result.user!.delete();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message.toString());
    }
    // await app.delete();
  }
}
