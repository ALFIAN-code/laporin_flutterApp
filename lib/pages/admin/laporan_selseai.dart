import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lapor_in/pages/theme/style.dart';

import '../../component/laporan_componen.dart';
import '../../model/user_model.dart';
import 'detail_laporan_admin.dart';

class LaporanSelesai extends StatefulWidget {
  const LaporanSelesai({super.key});
  static String routesName = '/laporanSelesai';

  @override
  State<LaporanSelesai> createState() => _LaporanSelesaiState();
}

class _LaporanSelesaiState extends State<LaporanSelesai> {
  final UserData userData = UserData();
  var uid = FirebaseAuth.instance.currentUser?.uid;
  
  @override
  void initState() {
    userData.get(uid);
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
          'Laporan Selesai',
          style: semiBold17.copyWith(color: Colors.grey[800], fontSize: 20),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('laporan')
            .where('status', isEqualTo: 'selesai')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('loading'),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: ListView.builder(
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  var timeStamp =
                      (snapshot.data?.docs[index]['tanggal'] as Timestamp)
                          .toDate();

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
                              FirebaseFirestore.instance
                                  .collection('laporan')
                                  .doc(snapshot.requireData.docs[index]
                                      ['id_laporan'])
                                  .delete();
                            },
                          )
                        ]),
                    child: LaporanView(
                        onTap: () {
                          Navigator.pushNamed(context,
                                            DetailLaporanAdmin.routeName,
                                            arguments: {
                                              'userData': userData,
                                              'laporanId': snapshot.data
                                                  ?.docs[index]['id_laporan']
                                            });
                        },
                        tanggal: DateFormat('kk:mm').format(timeStamp),
                        time: DateFormat('dd MMMM yyyy').format(timeStamp),
                        isiLaporan: snapshot.requireData.docs[index]
                            ['isi_laporan'],
                        judul: snapshot.requireData.docs[index]['judul'],
                        path: snapshot.requireData.docs[index]['url_image'],
                        status: snapshot.requireData.docs[index]['status']),
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
    );
  }
}
