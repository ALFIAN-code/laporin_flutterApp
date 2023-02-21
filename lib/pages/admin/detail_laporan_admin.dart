import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/pages/theme/style.dart';
import 'package:intl/intl.dart';
import 'package:lapor_in/pages/user/edit_page.dart';

class DetailLaporanAdmin extends StatefulWidget {
  const DetailLaporanAdmin({super.key});

  static String routeName = '/DetailLaporanAdmin';

  @override
  State<DetailLaporanAdmin> createState() => _DetailLaporanAdminState();
}

class _DetailLaporanAdminState extends State<DetailLaporanAdmin> {
  getLaporanData(String? id) {
    return FirebaseFirestore.instance.collection('laporan').doc(id).get();
  }

  @override
  Widget build(BuildContext context) {
    var bodyHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var argument = ModalRoute.of(context)?.settings.arguments;
    print('ini adalah agrument : $argument');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF1F3F4),
        body: SingleChildScrollView(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('laporan')
              .doc('$argument')
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 20),
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: InkWell(
                                  onTap: () {
                                    if (status == 'terkirim') {
                                      errorDialog(
                                          title: 'belum ada tanggapan',
                                          content:
                                              'laporan anda akan ditanggapi segera',
                                          context: context);
                                    } else {}
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: (status == 'terkirim')
                                            ? Colors.deepPurple
                                            : Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'tanggapi',
                                          style: medium15.copyWith(
                                              color: Colors.white),
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
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
