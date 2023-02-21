import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lapor_in/component/utils.dart';
import 'package:lapor_in/pages/admin/detail_laporan_admin.dart';
import 'package:lapor_in/pages/admin/laporan_selseai.dart';
import 'package:lapor_in/pages/admin/list_petugas_page.dart';
import 'package:lapor_in/pages/theme/style.dart';

import '../../component/laporan_componen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static String routesName = '/Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser;

  bool hasInternet = Utils.isConnected();
  bool isDataComplete = false;
  UserData userData = UserData();

  var uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    // setFullname();
    // getUserData();
    userData.get(uid);
    super.initState();
  }

  // Future getStatus() async {
  //   role = await Utils.getUserStatus();
  // }

  // setFullname() async {
  //   fullname = await getUserData();
  // }

  // Future<String> getUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String data = '';
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user?.uid)
  //       .get()
  //       .then((DocumentSnapshot document) {});
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
            )),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  // leadingWidth: 50,
                  toolbarHeight: 70,
                  flexibleSpace: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
                          child: SvgPicture.asset(
                            'lib/images/user2.svg',
                            color: Colors.grey[800],
                            height: 35,
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: userData.get(uid),
                        builder: (context, snapshot) {
                          return Text(
                            userData.fullname,
                            style: bold17.copyWith(
                                color: Colors.grey[800], fontSize: 20),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: userData.get(uid),
                        builder: (context, snapshot) => Text(
                          ' (${userData.role})',
                          style: regular15.copyWith(color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Utils.userSignOut(context);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.grey[800],
                        ))
                  ],
                )
              ];
            },
            body: Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                      child: Text(
                        'Dashboard',
                        style: bold25.copyWith(
                            color: const Color(0xff48294E), fontSize: 35),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          Navigator.pushNamed(
                              context, LaporanSelesai.routesName);
                        },
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(40, 12, 20, 12),
                          decoration: BoxDecoration(
                              color: const Color(0xffAFA1FF).withAlpha(130),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Laporan Selesai',
                                style: bold17.copyWith(
                                    fontSize: 18,
                                    color: const Color(0xff363636)),
                              ),
                              const Icon(
                                Icons.done,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: userData.get(uid),
                    builder: (context, snapshot) {
                      return (userData.role.contains('admin'))
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PetugasView.routesName);
                                  },
                                  child: Container(
                                    height: 70,
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 12, 20, 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'petugas',
                                          style: bold17.copyWith(
                                              fontSize: 18,
                                              color: const Color(0xff363636)),
                                        ),
                                        const Icon(
                                          Icons.person,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
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
                              'Diproses',
                              style: bold17.copyWith(fontSize: 15),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Riwayat',
                              style: bold17.copyWith(fontSize: 15),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('laporan')
                            .where('status', isEqualTo: 'terkirim')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: ListView.builder(
                                itemCount: snapshot.data?.size,
                                itemBuilder: (context, index) {
                                  var timeStamp = (snapshot.data?.docs[index]
                                          ['tanggal'] as Timestamp)
                                      .toDate();
                                  return LaporanView(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            DetailLaporanAdmin.routeName,
                                            arguments: snapshot.data
                                                ?.docs[index]['id_laporan']);
                                      },
                                      tanggal:
                                          DateFormat('kk:mm').format(timeStamp),
                                      time: DateFormat('dd MMMM yyyy')
                                          .format(timeStamp),
                                      isiLaporan: snapshot.requireData
                                          .docs[index]['isi_laporan'],
                                      judul: snapshot.requireData.docs[index]
                                          ['judul'],
                                      path: snapshot.requireData.docs[index]
                                          ['url_image'],
                                      status: snapshot.requireData.docs[index]
                                          ['status']);
                                },
                              ),
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('laporan')
                              .where('status', isEqualTo: 'diproses')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text('loading...'),
                              );
                            } else if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: ListView.builder(
                                  itemCount: snapshot.data?.size,
                                  itemBuilder: (context, index) {
                                    var timeStamp = (snapshot.data?.docs[index]
                                            ['tanggal'] as Timestamp)
                                        .toDate();
                                    return LaporanView(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              DetailLaporanAdmin.routeName,
                                              arguments: snapshot.data
                                                  ?.docs[index]['id_laporan']);
                                        },
                                        tanggal: DateFormat('kk:mm')
                                            .format(timeStamp),
                                        time: DateFormat('dd MMMM yyyy')
                                            .format(timeStamp),
                                        isiLaporan: snapshot.requireData
                                            .docs[index]['isi_laporan'],
                                        judul: snapshot.requireData.docs[index]
                                            ['judul'],
                                        path: snapshot.requireData.docs[index]
                                            ['url_image'],
                                        status: snapshot.requireData.docs[index]
                                            ['status']);
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
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('tanggapan')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text('loading...'),
                              );
                            } else if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: ListView.builder(
                                  itemCount: snapshot.data?.size,
                                  itemBuilder: (context, index) {
                                    var timeStamp = snapshot.requireData
                                        .docs[index]['tanggal'] as Timestamp;
                                    DateTime dateTime = timeStamp.toDate();
                                    var dateString =
                                        DateFormat('K:mm:ss').format(dateTime);

                                    return LaporanView(
                                        tanggal: '166',
                                        time: dateString,
                                        isiLaporan: snapshot.requireData
                                            .docs[index]['isi_laporan'],
                                        judul: snapshot.requireData.docs[index]
                                            ['judul'],
                                        path: snapshot.requireData.docs[index]
                                            ['url_image'],
                                        status: snapshot.requireData.docs[index]
                                            ['status']);
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
                    ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
