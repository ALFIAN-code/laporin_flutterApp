import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_in/component/utils.dart';

import '../../component/my_button.dart';
import '../theme/style.dart';
import 'home_page.dart';

class EditPage extends StatefulWidget {
  static String routesName = '/EditPage';
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // XFile? pickedImage;
  // UploadTask? uploadTask;
  // ImagePicker imagePicker = ImagePicker();

  String uniqueCode = DateTime.now().microsecondsSinceEpoch.toString();

  String imageUrl = '';
  String fullname = '';
  int telp = 0;
  int nik = 0;

  DateTime now = DateTime.now();

  User? currentUser = FirebaseAuth.instance.currentUser;
  // String laporanId = Random().nextInt(99999).toString();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    print('niknya adalah $nik');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? laporanId = ModalRoute.of(context)?.settings.arguments.toString();

    var appbar = AppBar(
      elevation: 0,
      title: const Text('Edit Laporan'),
      centerTitle: true,
      backgroundColor: const Color(0xffAFA1FF),
    );

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('laporan')
          .doc(laporanId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xffAFA1FF),
              appBar: appbar,
              body: Center(
                child: SingleChildScrollView(
                    child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      //nik Field
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            'Judul',
                            style: bold17.copyWith(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _judulController,
                        hint: snapshot.data?.get('judul'),
                        maxLine: 9,
                        minLine: 1,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //telp Field
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            'Alamat Kejadian',
                            style: bold17.copyWith(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _alamatController,
                        hint: snapshot.data?.get('alamat'),
                        maxLine: 9,
                        minLine: 1,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //alamat field
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            'Isi Laporan',
                            style: bold17.copyWith(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _deskripsiController,
                        hint: snapshot.data?.get('isi_laporan'),
                        maxLine: 9,
                        minLine: 5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(
                          onTap: () {
                            updateLaporan(laporanId);
                          },
                          color: const Color.fromARGB(255, 165, 177, 248),
                          child: Text(
                            'Ubah',
                            style: medium15.copyWith(color: Colors.white),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
        } else {
          return Text('loading...');
        }
      },
    );
  }

  // Future<void> getUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user?.uid)
  //       .snapshots()
  //       .listen((userData) {
  //     setState(() {
  //       fullname = userData.data()!['fullname'];
  //       nik = userData.data()!['nik'];
  //       telp = userData.data()!['telp'];
  //     });
  //   });
  //   print('$fullname $nik $telp');
  // }

  Future<void> updateLaporan(String? laporanID) async {
    // DateTime date = DateTime(
    //     now.year, now.month, now.day, now.hour, now.minute, now.second);
    if (_judulController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _deskripsiController.text.isEmpty) {
      Utils.showSnackBar('field tidak boleh kosong');
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('laporan')
            .doc(laporanID)
            .update({
          'judul': _judulController.text,
          'alamat': _alamatController.text,
          'isi_laporan': _deskripsiController.text,
        });
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on Exception catch (e) {
        Navigator.pop(context);
        Utils.showSnackBar(e.toString());
      }
    }
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
