import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/component/text_field.dart';
import 'package:lapor_in/component/utils.dart';

import '../theme/style.dart';

class AddPetugas extends StatefulWidget {
  const AddPetugas({super.key});

  static String routesName = '/addPetugas';

  @override
  State<AddPetugas> createState() => _AddPetugasState();
}

class _AddPetugasState extends State<AddPetugas> {
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

  void makeAccount() async {
    if (_emailController.text.isEmpty ||
        _fullnameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _telpController.text.isEmpty) {
      Utils.showSnackBar('field tidak boleh kosong');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: RefreshProgressIndicator());
        },
      );
      try {
        var user = await Utils.createUser(
            _emailController.text, _passwordController.text);

        FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          'fullname': _fullnameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'telp': _telpController.text,
          'uid': user.uid,
          'role': 'petugas'
        });

        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        Navigator.pop(context);
        Utils.showSnackBar(e.toString());
      }
    }
  }

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
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.number,
                inputFormater: [FilteringTextInputFormatter.digitsOnly],
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
                  makeAccount();
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
