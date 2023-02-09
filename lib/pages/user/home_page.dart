import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lapor_in/Services/auth_service.dart';
import 'package:lapor_in/component/laporan_componen.dart';
import 'package:lapor_in/pages/auth/auth_page.dart';
import 'package:lapor_in/pages/theme/style.dart';
import 'package:lapor_in/pages/user/add_laporan.dart';
import 'package:lapor_in/pages/user/lengkapi_data.dart';
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

  // ignore: prefer_typing_uninitialized_variables
  var userData = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  void _getdata() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      if (mounted) {
        setState(() {
          isDataComplete = userData.data()!['is_data_complete'];
        });
      }
    });
  }

  userSignOut(BuildContext context) {
    AuthService().googleLogout();
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AuthPage.routesName);
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? fullname = FirebaseAuth.instance.currentUser?.displayName as String;
    String firstname = fullname.split(' ').first;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              elevation: 0,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Color(0xffAFA1FF)),
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
                            Navigator.pushNamed(context, AddLaporan.routesName);
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(40, 12, 20, 12),
                            decoration: BoxDecoration(
                                color: const Color(0xffAFA1FF).withAlpha(130),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      padding: const EdgeInsets.all(30),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            onTap: () {
                              Navigator.pushReplacementNamed(
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
                                                  color:
                                                      const Color(0xff363636)),
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

                    //text riwayat laporan
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'Riwayat Laporan',
                        style: bold17,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //list riwayat laporan
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: LaporanView());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: )
          ],
        ));
  }
}
