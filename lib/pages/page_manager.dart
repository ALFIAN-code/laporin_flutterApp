import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/pages/admin/admin_dasboard.dart';
import 'package:lapor_in/pages/admin/petugas_dasboard.dart';
import 'package:lapor_in/pages/user/home_page.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});
  static String routesName = '/pageManager';

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  @override
  void initState() {
    super.initState();
    route();
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "user") {
          Navigator.pushReplacementNamed(context, HomePage.routesName);
        } else if (documentSnapshot.get('role') == "admin") {
          Navigator.pushReplacementNamed(context, AdminDashboard.routesName);
        } else if (documentSnapshot.get('role') == "petugas") {
          Navigator.pushReplacementNamed(context, PetugasDashboard.routesName);
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
