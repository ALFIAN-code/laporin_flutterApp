import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/pages/admin/admin_dasboard.dart';
import 'package:lapor_in/pages/admin/petugas_dasboard.dart';
import 'package:lapor_in/pages/user/home_page.dart';
import 'package:shimmer/shimmer.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});
  static String routesName = '/pageManager';

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  @override
  void initState() {
    setState(() {
      route();
    });
    super.initState();
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
    return Scaffold(
      body: Center(
          child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.grey[300],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Shimmer(
                  gradient:
                      const LinearGradient(colors: [Colors.grey, Colors.white]),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Shimmer(
                      gradient: const LinearGradient(
                          colors: [Colors.grey, Colors.white]),
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const LaporanListSkeleton(),
                const LaporanListSkeleton(),
                const LaporanListSkeleton(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class LaporanListSkeleton extends StatelessWidget {
  const LaporanListSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 10,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 10,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
