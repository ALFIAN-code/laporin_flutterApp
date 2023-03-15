import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/pages/theme/style.dart';
import 'package:intl/intl.dart';
import 'package:lapor_in/pages/user/edit_page.dart';

import '../fullscreen_image.dart';

class DetailLaporan extends StatefulWidget {
  const DetailLaporan({super.key});

  static String routeName = '/detailLaporan';

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  getLaporanData(String? id) {
    return FirebaseFirestore.instance.collection('laporan').doc(id).get();
  }

  @override
  Widget build(BuildContext context) {
    var bodyHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var laporanId = ModalRoute.of(context)?.settings.arguments;
    print('ini adalah agrument : $laporanId');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF1F3F4),
        body: SingleChildScrollView(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('laporan')
              .doc('$laporanId')
              .snapshots(),
          builder: (context, snapshot) {
            // print();

            if (snapshot.hasData) {
              var timeStamp =
                  (snapshot.data?.get('tanggal') as Timestamp).toDate();

              var status = snapshot.data?.get('status');
              return Stack(
                children: [
                  SizedBox(
                    height: bodyHeight * 0.4,
                    child: Image.network(
                      snapshot.data!.get('url_image'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: bodyHeight * 0.35),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 30),
                          child: Text(
                            snapshot.data!.get('judul'),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama Pelapor : ${snapshot.data!.get('nama_pelapor')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Nomor Telfon : ${snapshot.data!.get('telp')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'alamat : ${snapshot.data!.get('alamat')}',
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
                                '${snapshot.data!.get('isi_laporan')}',
                                style: regular15.copyWith(letterSpacing: 0.3),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        (status == 'terkirim')
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 20),
                                    child: Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: InkWell(
                                        onTap: () {
                                          if (status == 'terkirim') {
                                            Navigator.pushNamed(
                                                context, EditPage.routesName,
                                                arguments: laporanId);
                                          } else {
                                            errorDialog(
                                                title: 'tidak bisa mengedit',
                                                content:
                                                    'laporan yang sudah ditanggapi tidak bisa di rubah',
                                                context: context);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: (status == 'terkirim')
                                                  ? Colors.indigo
                                                  : Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Edit',
                                                style: medium15.copyWith(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),

                        (status == 'diproses' || status == 'selesai')
                            ? StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('tanggapan')
                                    .doc('$laporanId')
                                    .snapshots(),
                                builder: (context, snapshotTanggapan) {
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
                                              fontSize: 20,
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
                                })
                            : Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 30),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300]?.withAlpha(150),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Belum Ada Tangggapan',
                                        style: semiBold15,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'laporan anda akan ditanggapi segera',
                                        style: regular15.copyWith(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300]?.withAlpha(200),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Icon(
                                Icons.arrow_back,
                                // weight: 300,

                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              FullscreenImage.routeName,
                              arguments: snapshot.data!.get('url_image'),
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
                        ],
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
