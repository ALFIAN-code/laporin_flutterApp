import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/pages/dashboard/admin_dasboard.dart';
import 'package:lapor_in/pages/dashboard/petugas_dasboard.dart';
import 'package:lapor_in/pages/user/home_page.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  bool userPage = false;
  bool adminPage = false;
  bool petugasPage = false;

  @override
  void initState() {
    super.initState();
    final firestoreInstance = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "user") {
          userPage = true;
        } else {
          print('its not user');
        }
      }
    });
    firestoreInstance
        .collection('admin')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin") {
          adminPage = true;
        } else if (documentSnapshot.get('role') == "petugas") {
          petugasPage = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userPage) {
      return const HomePage();
    } else if (adminPage) {
      return const AdminDashboard();
    } else {
      return const PetugasDashboard();
    }
  }
}
