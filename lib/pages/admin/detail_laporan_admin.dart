import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/model/user_model.dart';
import 'package:lapor_in/pages/admin/report.dart';
import 'package:lapor_in/pages/fullscreen_image.dart';
import 'package:lapor_in/pages/theme/style.dart';
import 'package:intl/intl.dart';

import '../user/add_laporan.dart';

class DetailLaporanAdmin extends StatefulWidget {
  const DetailLaporanAdmin({super.key});
  // final String role;
  // final String laporanId;

  static String routeName = '/DetailLaporanAdmin';

  @override
  State<DetailLaporanAdmin> createState() => _DetailLaporanAdminState();
}

class _DetailLaporanAdminState extends State<DetailLaporanAdmin> {
  TextEditingController _tanggapanController = TextEditingController();

  DateTime now = DateTime.now();
  User? currentUser = FirebaseAuth.instance.currentUser;

  void sentTanggapan(String? id) {
    String random = Random().nextInt(99999).toString();
    DateTime date = DateTime(
        now.day, now.month, now.year, now.hour, now.minute, now.second);
    FirebaseFirestore.instance.collection('tanggapan').doc(id).set({
      'id_tanggapan': random,
      'id_laporan': id,
      'tanggal_tanggapan': date,
      'isi_tanggapan': _tanggapanController.text,
      'id_petugas': currentUser!.uid,
      // 'nama_petugas' : currentUser!.displayName
    });

    FirebaseFirestore.instance
        .collection('laporan')
        .doc(id)
        .update({'status': 'diproses'});
  }

  void laporanSelesai(String? id) {
    FirebaseFirestore.instance
        .collection('laporan')
        .doc(id)
        .update({'status': 'selesai'});
  }

  @override
  Widget build(BuildContext context) {
    var bodyHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    Map argument = ModalRoute.of(context)?.settings.arguments as Map;
    String? laporanId = argument['laporanId'];
    UserData userData = argument['userData'] as UserData;

    DocumentSnapshot<Map<String, dynamic>>? tanggapanData;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF1F3F4),
        body: SingleChildScrollView(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('laporan')
              .doc(laporanId)
              .snapshots(),
          builder: (context, snapshotLaporan) {
            // print();

            if (snapshotLaporan.hasData) {
              var timeStamp =
                  (snapshotLaporan.data?.get('tanggal') as Timestamp).toDate();

              var status = snapshotLaporan.data?.get('status');
              return Stack(
                children: [
                  SizedBox(
                    height: bodyHeight * 0.4,
                    child: Stack(children: [
                      Image.network(
                        snapshotLaporan.data!.get('url_image'),
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            FullscreenImage.routeName,
                            arguments: snapshotLaporan.data!.get('url_image'),
                          ),
                          child: Container(
                            // padding: EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 20, right: 20),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]?.withAlpha(200),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Center(
                              child: Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: bodyHeight * 0.35),
                    // height: bodyHeight,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 30),
                          child: Text(
                            snapshotLaporan.data!.get('judul'),
                            style: bold25.copyWith(color: Colors.grey[800]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 30),
                          child: Text(
                            DateFormat('dd MMMM yyyy - kk:mm')
                                .format(timeStamp),
                            style: regular15.copyWith(color: Colors.grey[800]),
                          ),
                        ),
                        Container(
                          // width: 120,
                          margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: (status == 'terkirim')
                                  ? Colors.grey
                                  : (status == 'diproses')
                                      ? Colors.yellow[700]
                                      : (status == 'selesai')
                                          ? Colors.green
                                          : Colors.grey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            (status == 'terkirim')
                                ? 'terkirim'
                                : (status == 'diproses')
                                    ? 'diproses'
                                    : (status == 'selesai')
                                        ? 'selesai'
                                        : 'error',
                            textAlign: TextAlign.center,
                            style: medium17.copyWith(color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama Pelapor : ${snapshotLaporan.data!.get('nama_pelapor')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'NIK: ${snapshotLaporan.data!.get('nik_pelapor')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Nomor Telfon : ${snapshotLaporan.data!.get('telp')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'alamat : ${snapshotLaporan.data!.get('alamat')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'id laporan : ${snapshotLaporan.data!.get('id_laporan')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'isi Laporan :',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${snapshotLaporan.data!.get('isi_laporan')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                        (status == 'terkirim')
                            ? CustomTextField(
                                controller: _tanggapanController,
                                hint: 'tanggapi laporan disini',
                                maxLine: 100,
                                minLine: 10,
                              )
                            : StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('tanggapan')
                                    .doc(laporanId)
                                    .snapshots(),
                                builder: (context, snapshotTanggapan) {
                                  //add snapshot tanggapan data variable
                                  tanggapanData = snapshotTanggapan.data;

                                  if (snapshotTanggapan.hasData) {
                                    DateTime tanggalTanggapan =
                                        (snapshotTanggapan.data!
                                                    .get('tanggal_tanggapan')
                                                as Timestamp)
                                            .toDate();
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 30),
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.grey[300]?.withAlpha(150),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tanggapan',
                                            style: bold25.copyWith(
                                              color: Colors.grey[800],
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'id tanggapan: ${snapshotTanggapan.data!.get('id_tanggapan')}',
                                            style: regular15.copyWith(
                                                letterSpacing: 0.3),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'id laporan : ${snapshotTanggapan.data!.get('id_laporan')}',
                                            style: regular15.copyWith(
                                                letterSpacing: 0.3),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'id petugas : ${snapshotTanggapan.data!.get('id_petugas')}',
                                            style: regular15.copyWith(
                                                letterSpacing: 0.3),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            DateFormat('dd MMMM yyyy, kk:mm')
                                                .format(tanggalTanggapan),
                                            style: regular15.copyWith(
                                                letterSpacing: 0.3),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'isi tanggapan :',
                                            style: regular15.copyWith(
                                                letterSpacing: 0.3),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${snapshotTanggapan.data!.get('isi_tanggapan')}',
                                            style: regular15.copyWith(
                                                letterSpacing: 0.3),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text('loading'),
                                    );
                                  }
                                }),
                        const SizedBox(
                          height: 20,
                        ),
                        (status != 'selesai')
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (userData.role == 'admin')
                                      ? TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Report(
                                                    laporanData:
                                                        snapshotLaporan.data,
                                                    tanggapanData:
                                                        tanggapanData,
                                                    namaPetugas:
                                                        userData.fullname,
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            'make PDF',
                                            style: semiBold15,
                                          ))
                                      : Container(
                                          width: 90,
                                        ),
                                  Material(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    child: InkWell(
                                      onTap: () {
                                        if (status == 'diproses') {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('konfirmasi'),
                                                content: const Text(
                                                    'apakah laporan ini telah selesai dikerjakan '),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'tidak',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      laporanSelesai(laporanId);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'ya',
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          sentTanggapan(laporanId);
                                        }
                                      },
                                      child: CustomButton(status: status),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, left: 20),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300]?.withAlpha(100),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Icon(
                            Icons.arrow_back,
                            // weight: 300,

                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              );
            } else {
              return Center(
                child: Text('loading'),
              );
            }
          },
        )),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.status,
  });

  final status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: (status == 'terkirim')
              ? Colors.deepPurple
              : Colors.green.withAlpha(200),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            (status == 'terkirim') ? 'tanggapi' : 'selesai',
            style: medium15.copyWith(color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
