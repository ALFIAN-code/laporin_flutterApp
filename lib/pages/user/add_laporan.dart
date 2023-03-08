import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapor_in/component/utils.dart';

import '../../component/my_button.dart';
import '../theme/style.dart';
import 'home_page.dart';

class AddLaporan extends StatefulWidget {
  static String routesName = '/addLaporan';
  const AddLaporan({super.key});

  @override
  State<AddLaporan> createState() => _AddLaporanState();
}

class _AddLaporanState extends State<AddLaporan> {
  XFile? pickedImage;
  // UploadTask? uploadTask;
  ImagePicker imagePicker = ImagePicker();

  String uniqueCode = DateTime.now().microsecondsSinceEpoch.toString();

  String imageUrl = '';
  String fullname = '';
  int telp = 0;
  int nik = 0;

  DateTime now = DateTime.now();

  User? currentUser = FirebaseAuth.instance.currentUser;
  String laporanId = Random().nextInt(99999).toString();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      elevation: 0,
      title: const Text('Buat Laporan'),
      centerTitle: true,
      backgroundColor: const Color(0xffAFA1FF),
    );
    var bodyHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffAFA1FF),
        appBar: appbar,
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //pick image
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: (pickedImage != null)
                        ? Image.file(
                            File(pickedImage!.path),
                            height: MediaQuery.of(context).size.height * 0.35,
                          )
                        : Container(
                            height: bodyHeight * 0.35,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 241, 241),
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.camera_alt),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'select image',
                                    style: medium15,
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('upload gambar ini?'),
                            content: const Text(
                                'gambar yang sudah diupload tidak bisa dirubah kembali'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'tidak',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  uploadImage();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'ya',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('upload')),

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
                  hint: 'kecelakaan mobil',
                  maxLine: 9,
                  minLine: 1,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                  hint: 'jl.sama kamu, gubeng, kota surabaya',
                  maxLine: 9,
                  minLine: 1,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                  hint: 'isi detail kejadian disini',
                  maxLine: 9,
                  minLine: 1,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    onTap: () {
                      uploadImage();
                      uploadLaporan();
                    },
                    color: const Color.fromARGB(255, 165, 177, 248),
                    child: Text(
                      'Kirim',
                      style: medium15.copyWith(color: Colors.white),
                    )),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _getImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = image;
    });
    // print('lokasi gambar : ${pickedImage!.path}');
    // print('nama gambar : ${pickedImage!.name}');
  }

  void getUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        fullname = userData.data()!['fullname'];
        nik = userData.data()!['nik'];
        telp = userData.data()!['telp'];
      });
    });
    print('$fullname $nik $telp');
  }

  void uploadImage() async {
    getUserData();
    if (pickedImage == null)
      return Utils.showSnackBar('pilih gambar terlebih dahulu');
    Reference refrenceRoot = FirebaseStorage.instance.ref();
    Reference refrenceDirImage =
        refrenceRoot.child('laporan/${currentUser!.email}');

    Reference refrengeImageToUpload = refrenceDirImage.child(uniqueCode);
    try {
      await refrengeImageToUpload.putFile(File(pickedImage!.path));
      imageUrl = await refrengeImageToUpload.getDownloadURL();

      print('ini adalah link download : $imageUrl');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future<void> uploadLaporan() async {
    DateTime date = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    if (imageUrl.isEmpty) {
      Utils.showSnackBar('upload gambar terlebih dahulu');
    } else if (_judulController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _deskripsiController.text.isEmpty) {
      Utils.showSnackBar('field tidak boleh kosong');
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('laporan')
            .doc(laporanId)
            .set({
          'url_image': imageUrl,
          'nama_pelapor': fullname,
          'id_pelapor': currentUser!.uid,
          'id_laporan': laporanId,
          'tanggal': date,
          'nik_pelapor': nik,
          'telp': telp,
          'judul': _judulController.text,
          'alamat': _alamatController.text,
          'isi_laporan': _deskripsiController.text,
          'status': 'terkirim'
        });
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, HomePage.routesName);
      } on Exception catch (e) {
        Navigator.pushReplacementNamed(context, HomePage.routesName);
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
