import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/component/utils.dart';
import 'package:shimmer/shimmer.dart';

import 'admin/dashboard.dart';
import 'user/home_page.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});
  static String routesName = '/pageManager';

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  Timer? timer;

  String role = '';
  @override
  void initState() {
    getRole();
    // if (mounted) {
    //   timer = Timer.periodic(
    //       const Duration(milliseconds: 100), (Timer t) => route());
    // }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getRole() async {
    role = await Utils.getUserStatus();
  }

  // Future<Object> route() async {
  //   Widget route = const HomePage();
  //   if (role.contains('user')) {
  //     timer!.cancel();
  //     // Navigator.pushReplacementNamed(context, HomePage.routesName);
  //     route = const HomePage();
  //   } else if (role.contains('admin') || role.contains('petugas')) {
  //     timer!.cancel();
  //     route = const Dashboard();
  //     // Navigator.pushReplacementNamed(context, Dashboard.routesName);
  //   }
  //   return route;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getRole(),
        builder: (context, snapshot) {
          if (role.contains('user')) {
            return const HomePage();
          } else if (role.contains('admin') || role.contains('petugas')) {
            return const Dashboard();
          } else {
            return const Text('error');
          }
          // return route;
        },
      ),
    );

//     return Scaffold(
//       body: Center(
//           child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.8,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 Shimmer(
//                   gradient: LinearGradient(
//                       colors: [Colors.grey.shade300, Colors.white]),
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 20),
//                     height: 100,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(30))),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Shimmer(
//                       gradient: LinearGradient(
//                           colors: [Colors.grey.shade300, Colors.white]),
//                       child: Container(
//                         width: 200,
//                         height: 30,
//                         decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(30))),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const LaporanListSkeleton(),
//                 const LaporanListSkeleton(),
//                 const LaporanListSkeleton(),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }

// class LaporanListSkeleton extends StatelessWidget {
//   const LaporanListSkeleton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer(
//       gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         child: Row(
//           children: [
//             Expanded(
//                 flex: 1,
//                 child: Container(
//                   height: 100,
//                   decoration: const BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//                 )),
//             Expanded(
//                 flex: 3,
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 200,
//                       height: 20,
//                       decoration: const BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.all(Radius.circular(30))),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       width: 200,
//                       height: 10,
//                       decoration: const BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.all(Radius.circular(30))),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       width: 200,
//                       height: 10,
//                       decoration: const BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.all(Radius.circular(30))),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
  }
}
