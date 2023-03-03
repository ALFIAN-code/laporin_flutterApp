import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/component/utils.dart';
import 'package:lapor_in/pages/theme/style.dart';

import 'add_petugas.dart';

// ignore: must_be_immutable
class PetugasView extends StatefulWidget {
  const PetugasView({super.key});
  static String routesName = '/petugasView';

  @override
  State<PetugasView> createState() => _PetugasViewState();
}

class _PetugasViewState extends State<PetugasView> {
  List petugasId = [];
  // Map<String, dynamic> petugasData = {};
  // bool hasData = false;

  // var petugasData = FirebaseFirestore.instance
  //     .collection('users')
  //     .where('role', isEqualTo: 'petugas');

  void getPetugasId() async {
    petugasId = [];
    // ignore: avoid_function_literals_in_foreach_calls
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'petugas')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              petugasId.add('');
            }));
  }

  

  @override
  void initState() {
    getPetugasId();
    super.initState();
  }

  // void isDataEmpty() async {
  //   if (await petugasData.snapshots().isEmpty) {
  //     hasData = true;
  //   } else {
  //     hasData = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            )),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'List Petugas',
          style: semiBold17.copyWith(color: Colors.grey[800], fontSize: 20),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Stack(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'petugas')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('tidak ada data');
                }
                else if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: snapshot.data?.size,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  autoClose: true,
                                  icon: Icons.delete,
                                  foregroundColor:
                                      const Color.fromARGB(255, 202, 59, 49),
                                  onPressed: (context) {
                                    Utils.deleteUser(
                                        snapshot.data?.docs[index]['uid'],
                                        snapshot.data?.docs[index]
                                            ['email'],
                                        snapshot.data?.docs[index]
                                            ['password']);
                                  },
                                )
                              ]),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('lib/images/petugas_icon.png'),
                            ),
                            subtitle:
                                Text(snapshot.requireData.docs[index]['email']),
                            title: Text(
                                snapshot.requireData.docs[index]['fullname']),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('tidak ada data'),
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: MyButton(
                  onTap: () {
                    Navigator.pushNamed(context, AddPetugas.routesName);
                  },
                  color: Colors.deepPurple,
                  child: Text(
                    'Tambah Petugas',
                    style: bold17.copyWith(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
