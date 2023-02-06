import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/error_dialog.dart';
import 'package:lapor_in/pages/page_manager.dart';
import 'package:lapor_in/pages/user/home_page.dart';
import '../../component/my_button.dart';
import '../../component/text_field.dart';
import '../theme/style.dart';

class UserDataForm extends StatefulWidget {
  const UserDataForm({super.key});

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  // ignore: prefer_typing_uninitialized_variables
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();

  void addData(String nik, String telp) {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection('user').doc(currentUser?.uid).set({
        'nik': int.parse(nik),
        'telp': int.parse(telp),
      });
    } catch (e) {
      if (_fullnameController.text.isEmpty) {
        errorDialog(
            title: 'nama kosong',
            content: 'isi kolom nama dengan benar',
            context: context);
      } else if (_nikController.text.isEmpty) {
        errorDialog(
            title: 'nik kosong',
            content: 'ini kolom nik dengan benar',
            context: context);
      } else if (_telpController.text.isEmpty) {
        errorDialog(
            title: 'nomer telepon kosong',
            content: 'ini kolom nomor telepon dengan benar',
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //top title
              Image.asset(
                'lib/images/add_data.jpg',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 30,
              ),
              Text('Lengkapi Data',
                  style: bold25.copyWith(color: const Color(0xff575151))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text('lengkapi data agar aplikasi bisa berjalan lancar',
                    textAlign: TextAlign.center,
                    style: regular15.copyWith(color: const Color(0xff575151))),
              ),
              const SizedBox(
                height: 30,
              ),

              //field
              //nama lengkap field
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Nama Lengkap',
                    style: bold17.copyWith(color: Colors.grey[700]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: _fullnameController,
                  hint: 'ahmad syaifudin',
                  obsecureText: false,
                  textCapitalization: TextCapitalization.none),
              const SizedBox(
                height: 20,
              ),

              //nik field
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'NIK',
                    style: bold17.copyWith(color: Colors.grey[700]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: _nikController,
                  hint: '3517************',
                  keyboardType: TextInputType.number,
                  inputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  obsecureText: false,
                  textCapitalization: TextCapitalization.none),
              const SizedBox(
                height: 20,
              ),

              //nomor telpon field
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Nomor Telepon',
                    style: bold17.copyWith(color: Colors.grey[700]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: _telpController,
                  hint: '0815********',
                  keyboardType: TextInputType.number,
                  inputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  obsecureText: false,
                  textCapitalization: TextCapitalization.none),
              const SizedBox(
                height: 20,
              ),

              //add data form
              MyButton(
                  onTap: () {
                    addData(_nikController.text, _telpController.text);
                    Navigator.pushReplacementNamed(
                        context, HomePage.routesName);
                  },
                  color: const Color.fromARGB(255, 255, 109, 51),
                  child: Text(
                    'Selesai',
                    style: bold17.copyWith(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
