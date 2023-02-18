import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/component/text_field.dart';
// import 'package:lapor_in/pages/admin/dashboard.dart';

// import '../../component/utils.dart';
import '../theme/style.dart';

class AddPetugas extends StatefulWidget {
  const AddPetugas({super.key});

  static String routesName = '/addPetugas';

  @override
  State<AddPetugas> createState() => _AddPetugasState();
}

class _AddPetugasState extends State<AddPetugas> {
  XFile? pickedImage;
  ImagePicker imagePicker = ImagePicker();
  String imageUrl = '';
  String uniqueCode = DateTime.now().microsecondsSinceEpoch.toString();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    _telpController.dispose();
    super.dispose();
  }

  // void uploadImage() async {
  //   if (pickedImage == null) return;
  //   Reference refrenceRoot = FirebaseStorage.instance.ref();
  //   Reference refrenceDirImage =
  //       refrenceRoot.child('laporan/${_emailController.text}');

  //   Reference refrengeImageToUpload = refrenceDirImage.child(uniqueCode);
  //   try {
  //     await refrengeImageToUpload.putFile(File(pickedImage!.path));
  //     imageUrl = await refrengeImageToUpload.getDownloadURL();

  //     print('ini adalah link download : $imageUrl');
  //   } catch (e) {
  //     Utils.showSnackBar(e.toString());
  //   }
  // }

  // void _getImage() async {
  //   XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     pickedImage = image;
  //   });
  // }

  // void makeAccount() async {
  //   uploadImage();
  //   if (imageUrl.isEmpty) {
  //     Utils.showSnackBar('upload gambar terlebih dahulu');
  //   } else if (_emailController.text.isEmpty ||
  //       _fullnameController.text.isEmpty ||
  //       _passwordController.text.isEmpty ||
  //       _telpController.text.isEmpty) {
  //     Utils.showSnackBar('field tidak boleh kosong');
  //   } else {
  //     try {
  //       // FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       //     email: _emailController.text, password: _passwordController.text);

  //       FirebaseApp app = await Firebase.initializeApp(
  //           name: 'secondary', options: Firebase.app().options);
  //       await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
  //           email: _emailController.text, password: _passwordController.text);

  //       await FirebaseFirestore.instance.collection('users').doc().set({
  //         'url_image': imageUrl,
  //         'nama': _fullnameController.text,
  //         'password': _passwordController.text,
  //         'telp': _telpController.text,
  //         'role': 'petugas'
  //       });
  //       // ignore: use_build_context_synchronously
  //       Navigator.pushReplacementNamed(context, Dashboard.routesName);
  //     } on Exception catch (e) {
  //       Navigator.pushReplacementNamed(context, Dashboard.routesName);
  //       Utils.showSnackBar(e.toString());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
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
        'Tambah Petugas',
        style: semiBold17.copyWith(color: Colors.grey[800], fontSize: 20),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              // onTap: _getImage,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: (pickedImage != null)
                    ? Image.file(
                        File(pickedImage!.path),
                        height: MediaQuery.of(context).size.height * 0.35,
                      )
                    : Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 241, 241),
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Nama Petugas',
                  style: bold17.copyWith(
                      color: const Color.fromARGB(255, 82, 82, 82)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: _fullnameController,
                hint: 'Nama Panjang',
                obsecureText: false,
                textCapitalization: TextCapitalization.words),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Email',
                  style: bold17.copyWith(
                      color: const Color.fromARGB(255, 82, 82, 82)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: _emailController,
                hint: 'Example@mail.com (email aktif)',
                obsecureText: false,
                textCapitalization: TextCapitalization.words),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Nomer Telpon',
                  style: bold17.copyWith(
                      color: const Color.fromARGB(255, 82, 82, 82)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: _telpController,
                hint: '0815********',
                obsecureText: false,
                textCapitalization: TextCapitalization.words),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'pasword',
                  style: bold17.copyWith(
                      color: const Color.fromARGB(255, 82, 82, 82)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: _passwordController,
                hint: '**********',
                obsecureText: true,
                textCapitalization: TextCapitalization.words),
            const SizedBox(
              height: 30,
            ),
            MyButton(
                onTap: () {
                  // makeAccount();
                },
                color: Colors.deepPurple,
                child: Text(
                  'Tambah',
                  style: bold17.copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
