import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/component/laporan_componen.dart';
import 'package:lapor_in/pages/user/detail_laporan.dart';
import '../../component/utils.dart';
import '../../model/user_model.dart';
import '../theme/style.dart';
import 'add_laporan.dart';
import 'lengkapi_data.dart';

class HomePage extends StatefulWidget {
  static String routesName = '/homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData userData = UserData();
  // bool hasInternet = Utils.isConnected();
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    userData.get(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: AppBar(
                elevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Color(0xffAFA1FF)),
              )),
          backgroundColor: const Color(0xffAFA1FF),
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      elevation: 0.0,
                      leading: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          'lib/images/user2.svg',
                          color: Colors.white,
                          height: 50,
                        ),
                      ),
                      title: FutureBuilder(
                        future: userData.get(uid),
                        builder: (context, snapshot) => Text(
                          userData.fullname,
                          style: regular17.copyWith(fontSize: 20),
                        ),
                      ),
                      backgroundColor: const Color(0xffAFA1FF),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(100),
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: userData.get(uid),
                                builder: (context, snapshot) {
                                  String firstname =
                                      (userData.fullname.split(' ').length < 2)
                                          ? userData.fullname
                                          : userData.fullname.split(' ')[0];
                                  // Navigator.pop(context);
                                  return Text(
                                    'hallo $firstname',
                                    maxLines: 1,
                                    style: regular17.copyWith(
                                        color: Colors.white, fontSize: 24),
                                  );
                                },
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                'Have a nice day',
                                style: bold25.copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(1000)),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Utils.userSignOut(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    'Log Out',
                                    style: regular12_5.copyWith(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.logout,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ];
                },
                body: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      //tambah laporan button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            onTap: () {
                              if (userData.isDataComplete) {
                                Navigator.pushNamed(
                                    context, AddLaporan.routesName);
                              } else {
                                errorDialog(
                                    title:
                                        'harap lengkapi data terlebih dahulu',
                                    content: '',
                                    context: context);
                              }
                            },
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.fromLTRB(40, 12, 20, 12),
                              decoration: BoxDecoration(
                                  color: const Color(0xffAFA1FF).withAlpha(130),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Buat Laporan baru',
                                        style: bold17.copyWith(
                                            fontSize: 18,
                                            color: const Color(0xff363636)),
                                      ),
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                            'Laporan akan otomtis diteruskan ke instansi terkait',
                                            maxLines: 2,
                                            style: regular15),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.add,
                                    size: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //lengkapi data button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LengkapiData.routesName);
                                // Navigator.pushNamed(
                                //     context, LengkapiData.routesName);
                              },
                              child: FutureBuilder(
                                future: userData.get(uid),
                                builder: (context, snapshot) {
                                  return userData.isDataComplete
                                      ? Container()
                                      : Container(
                                          height: 110,
                                          width: double.infinity,
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 12, 20, 12),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF0000)
                                                  .withAlpha(130),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Lengkapi data anda',
                                                    style: bold17.copyWith(
                                                        fontSize: 18,
                                                        color: const Color(
                                                            0xff363636)),
                                                  ),
                                                  SizedBox(
                                                    width: 190,
                                                    child: Text(
                                                        'agar laporan anda bisa di eksekusi dengan baik',
                                                        maxLines: 2,
                                                        style: regular15),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                Icons.report_problem,
                                                size: 50,
                                              )
                                            ],
                                          ),
                                        );
                                },
                              )),
                        ),
                      ),
                      //text riwayat & tanggapan view
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 15),
                              child: TabBar(
                                  labelColor: Colors.grey[800],
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor:
                                      const Color.fromARGB(255, 184, 140, 255),
                                  indicatorWeight: 4,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Laporan Baru',
                                        style: bold17.copyWith(fontSize: 15),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'selesai',
                                        style: bold17.copyWith(fontSize: 15),
                                      ),
                                    ),
                                  ]),
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                // list riwayat laporan

                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('laporan')
                                      .where('id_pelapor', isEqualTo: uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: ListView.builder(
                                          itemCount: snapshot.data?.size,
                                          itemBuilder: (context, index) {
                                            var timeStamp = (snapshot
                                                        .data?.docs[index]
                                                    ['tanggal'] as Timestamp)
                                                .toDate();

                                            if (snapshot.data?.docs[index]
                                                    ['status'] !=
                                                'selesai') {
                                              return Slidable(
                                                endActionPane: ActionPane(
                                                    extentRatio: 0.2,
                                                    motion:
                                                        const DrawerMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        autoClose: true,
                                                        icon: Icons.delete,
                                                        foregroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                202,
                                                                59,
                                                                49),
                                                        onPressed: (context) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'laporan')
                                                              .doc(snapshot
                                                                      .requireData
                                                                      .docs[index]
                                                                  [
                                                                  'id_laporan'])
                                                              .delete();
                                                        },
                                                      )
                                                    ]),
                                                child: LaporanView(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          DetailLaporan
                                                              .routeName,
                                                          arguments: snapshot
                                                                  .requireData
                                                                  .docs[index]
                                                              ['id_laporan']);
                                                    },
                                                    tanggal:
                                                        DateFormat('dd MMMM yyyy')
                                                            .format(timeStamp),
                                                    time: DateFormat('kk:mm')
                                                        .format(timeStamp),
                                                    isiLaporan: snapshot
                                                            .requireData
                                                            .docs[index]
                                                        ['isi_laporan'],
                                                    judul: snapshot.requireData
                                                        .docs[index]['judul'],
                                                    path: snapshot.requireData
                                                            .docs[index]
                                                        ['url_image'],
                                                    status: snapshot.requireData
                                                        .docs[index]['status']),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      );
                                    } else {
                                      return Center(
                                          child:
                                              const CircularProgressIndicator());
                                    }
                                  },
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('laporan')
                                      .where('id_pelapor', isEqualTo: uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: ListView.builder(
                                          itemCount: snapshot.data?.size,
                                          itemBuilder: (context, index) {
                                            var timeStamp = (snapshot
                                                        .data?.docs[index]
                                                    ['tanggal'] as Timestamp)
                                                .toDate();

                                            if (snapshot.data?.docs[index]
                                                    ['status'] ==
                                                'selesai') {
                                              return Slidable(
                                                endActionPane: ActionPane(
                                                    extentRatio: 0.2,
                                                    motion:
                                                        const DrawerMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        autoClose: true,
                                                        icon: Icons.delete,
                                                        foregroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                202,
                                                                59,
                                                                49),
                                                        onPressed: (context) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'laporan')
                                                              .doc(snapshot
                                                                      .requireData
                                                                      .docs[index]
                                                                  [
                                                                  'id_laporan'])
                                                              .delete();
                                                        },
                                                      )
                                                    ]),
                                                child: LaporanView(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          DetailLaporan
                                                              .routeName,
                                                          arguments: snapshot
                                                                  .requireData
                                                                  .docs[index]
                                                              ['id_laporan']);
                                                    },
                                                    tanggal:
                                                        DateFormat('dd MMMM yyyy')
                                                            .format(timeStamp),
                                                    time: DateFormat('kk:mm')
                                                        .format(timeStamp),
                                                    isiLaporan: snapshot
                                                            .requireData
                                                            .docs[index]
                                                        ['isi_laporan'],
                                                    judul: snapshot.requireData
                                                        .docs[index]['judul'],
                                                    path: snapshot.requireData
                                                            .docs[index]
                                                        ['url_image'],
                                                    status: snapshot.requireData
                                                        .docs[index]['status']),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      );
                                    } else {
                                      return Center(
                                          child:
                                              const CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final int maxLine, minLine;
  final String hint;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.maxLine,
      required this.minLine,
      this.contentPadding,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07),
      child: TextField(
        controller: controller,
        minLines: minLine,
        maxLines: maxLine,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            hintText: hint,
            filled: true,
            hintStyle: medium15.copyWith(color: Colors.grey.shade500),
            contentPadding: contentPadding,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
