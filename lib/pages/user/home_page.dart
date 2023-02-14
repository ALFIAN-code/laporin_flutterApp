import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lapor_in/Services/auth_service.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/pages/user/get_lapporan_data.dart';
import '../../auth_page.dart';
import '../theme/style.dart';
import 'add_laporan.dart';
import 'lengkapi_data.dart';
// import 'package:lapor_in/pages/theme/style.dart';

class HomePage extends StatefulWidget {
  static String routesName = '/homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var currentUser = FirebaseAuth.instance.currentUser;
  bool isDataComplete = false;
  String fullname = '';
  String userId = '';
  // ignore: prefer_typing_uninitialized_variables
  var hasInternet = true;
  List<String> laporanId = [];

  void isConnected() {
    InternetConnectionCheckerPlus.createInstance()
        .onStatusChange
        .listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        hasInternet = false;
      } else if (status == InternetConnectionStatus.connected) {
        hasInternet = true;
      }
    });
  }

  void getLaporanId() async {
    List<String> data = [];
    User? user = FirebaseAuth.instance.currentUser;
    if (hasInternet) {
      await FirebaseFirestore.instance
          .collection('laporan')
          .where('id_pelapor', isEqualTo: user!.uid)
          .get()
          // ignore: avoid_function_literals_in_foreach_calls
          .then((snapshot) => snapshot.docs.forEach((element) {
                // print(element.reference);
                if (snapshot.docs.isNotEmpty) {
                  if (!laporanId.contains(element.id)) {
                    data.add(element.reference.id);
                  }
                }
              }));
      laporanId = data;
    }
  }

  @override
  void initState() {
    isConnected();
    getLaporanId();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String firstname =
        (fullname.split(' ').length < 2) ? fullname : fullname.split(' ').first;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          getLaporanId();
        });
      },
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
                          height: 50,
                        ),
                      ),
                      title: Text(
                        fullname,
                        style: semiBold17,
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
                              Text(
                                'hallo $firstname',
                                maxLines: 1,
                                style: regular17.copyWith(
                                    color: Colors.white, fontSize: 24),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                'Selamat Pagi',
                                style: bold25.copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () {
                            userSignOut(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Text(
                                  'Log Out',
                                  style: regular12_5.copyWith(fontSize: 12),
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
                              if (isDataComplete) {
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
                                    // mainAxisAlignment: MainAxisAlignment.center,
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
                              child: isDataComplete
                                  ? Container()
                                  : Container(
                                      height: 110,
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 12, 20, 12),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF0000)
                                              .withAlpha(130),
                                          borderRadius: const BorderRadius.all(
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
                                                MainAxisAlignment.spaceEvenly,
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
                                    )),
                        ),
                      ),
                      //text riwayat & tanggapan view
                      Expanded(
                        child: DefaultTabController(
                            initialIndex: 0,
                            length: 2,
                            child: Column(
                              children: [
                                Container(
                                  // height: 50,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: TabBar(
                                      labelColor: Colors.grey[800],
                                      unselectedLabelColor: Colors.grey,
                                      indicatorColor: const Color.fromARGB(
                                          255, 184, 140, 255),
                                      indicatorWeight: 4,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      isScrollable: true,
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            'Riwayat',
                                            style:
                                                bold17.copyWith(fontSize: 15),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'tanggapan',
                                            style:
                                                bold17.copyWith(fontSize: 15),
                                          ),
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: TabBarView(children: [
                                    // list riwayat laporan
                                    (hasInternet)
                                        ? (laporanId.isNotEmpty)
                                            ? StreamBuilder(
                                                builder: (context, snapshot) {
                                                  return ListView.builder(
                                                    itemCount: laporanId.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Slidable(
                                                        endActionPane: ActionPane(
                                                            extentRatio: 0.2,
                                                            motion:
                                                                const DrawerMotion(),
                                                            children: [
                                                              SlidableAction(
                                                                autoClose: true,
                                                                onPressed:
                                                                    (context) {
                                                                  setState(() {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'laporan')
                                                                        .doc(laporanId[
                                                                            index])
                                                                        .delete();
                                                                  });
                                                                },
                                                                backgroundColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        212,
                                                                        70,
                                                                        60),
                                                                icon: Icons
                                                                    .delete,
                                                              ),
                                                            ]),
                                                        key: ValueKey(index),
                                                        child: GetLaporanData(
                                                            laporanId:
                                                                laporanId[
                                                                    index]),
                                                      );
                                                    },
                                                  );
                                                },
                                              )
                                            : const Center(
                                                child: Text(
                                                    'kamu belum membuat laporan'),
                                              )
                                        : const Center(
                                            child: Text('tidak ada internet')),

                                    const Center(
                                      child: Text('tanggapan view'),
                                    )
                                  ]),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  var userData = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  void getUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      if (mounted) {
        setState(() {
          isDataComplete = userData.data()!['is_data_complete'];
          fullname = userData.data()!['fullname'];
        });
      }
    });
  }

  void userSignOut(BuildContext context) {
    AuthService().googleLogout();
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AuthPage.routesName);
  }
}

//  FutureBuilder(
//                                   future: getLaporanId(),
//                                   builder: (context, snapshot) {
//                                     return Expanded(child: LayoutBuilder(
//                                       builder: (context, constraint) {
//                                         if (constraint.maxWidth < 700) {
//                                           return ListView.builder(
//                                             itemCount: laporanId.length,
//                                             itemBuilder: (context, index) {
//                                               return GetLaporanData(
//                                                   laporanId: laporanId[index]);
//                                             },
//                                           );
//                                         } else if (constraint.maxWidth < 1600) {
//                                           return GridView.builder(
//                                             gridDelegate:
//                                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount: 2),
//                                             itemCount: laporanId.length,
//                                             itemBuilder: (context, index) {
//                                               return GetLaporanData(
//                                                   laporanId: laporanId[index]);
//                                             },
//                                           );
//                                         } else {
//                                           return GridView.builder(
//                                             gridDelegate:
//                                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount: 3),
//                                             itemCount: laporanId.length,
//                                             itemBuilder: (context, index) {
//                                               return GetLaporanData(
//                                                   laporanId: laporanId[index]);
//                                             },
//                                           );
//                                         }
//                                       },
//                                     ));
//                                   },
//                                 )


