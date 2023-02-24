import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/my_button.dart';
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

  var petugasData = FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'petugas');

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
              stream: petugasData.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text('loading...'),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: snapshot.data?.size,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage('lib/images/petugas_icon.png'),
                          ),
                          subtitle:
                              Text(snapshot.requireData.docs[index]['email']),
                          title: Text(
                              snapshot.requireData.docs[index]['fullname']),
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
