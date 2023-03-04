import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../component/my_button.dart';
import '../../../component/text_field.dart';
import '../../../component/utils.dart';
import '../theme/style.dart';
import 'home_page.dart';
// import 'package:lapor_in/component/text_field.dart';

class LengkapiData extends StatefulWidget {
  static String routesName = '/lengkapiData';
  const LengkapiData({super.key});

  @override
  State<LengkapiData> createState() => _LengkapiDataState();
}

class _LengkapiDataState extends State<LengkapiData> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final TextEditingController _nikController = TextEditingController();

  final TextEditingController _telpController = TextEditingController();

  final TextEditingController _alamatController = TextEditingController();
  // 'fullname': currentUser?.displayName,
  //                     'email': currentUser?.email,
  //                     'role': 'user',
  //                     'is_data_complete': false
  String password = '';
  String role = '';
  String email = '';
  String displayName = '';

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      if (mounted) {
        setState(() {
          password = userData.data()!['password'];
          role = userData.data()!['role'];
          email = userData.data()!['email'];
          displayName = userData.data()!['fullname'];
        });
      }
    });
  }

  Future<void> addData(
      int nik, int telp, String alamat, BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: RefreshProgressIndicator(
                color: Color(0xff8CCD00),
              ),
            );
          });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.uid)
          .set({
        'password' : password,
        'email': email,
        'fullname': displayName,
        'nik': nik,
        'telp': telp,
        'alamat': alamat,
        'role': role,
        'is_data_complete': true
      });
      // ignore: use_build_context_synchronously
      if (mounted) {
        Navigator.pop(context);
      }
      Navigator.pushReplacementNamed(context, HomePage.routesName);
      Utils.showSnackBar('data sukses ditambahkan');
    } catch (e) {
      Navigator.pop(context);
      if (_nikController.text.isEmpty ||
          _telpController.text.isEmpty ||
          _alamatController.text.isEmpty) {
        Utils.showSnackBar('data tidak boleh kosong');
      }
    }
  }

  @override
  void dispose() {
    _alamatController.dispose();
    _nikController.dispose();
    _telpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePage.routesName);
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0,
        title: const Text('Lengkapi Data'),
        backgroundColor: const Color(0xffAFA1FF),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //display image
              Image.asset(
                'lib/images/lengkapi_data.jpg',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              //nik Field
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    'Masukan NIK',
                    style: bold17.copyWith(
                        color: const Color.fromARGB(255, 82, 82, 82)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: _nikController,
                hint: '3517************',
                obsecureText: false,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.number,
                inputFormater: [FilteringTextInputFormatter.digitsOnly],
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
                    'Nomor Telepon',
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
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.number,
                inputFormater: [FilteringTextInputFormatter.digitsOnly],
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
                    'Masukan Alamat',
                    style: bold17.copyWith(
                        color: const Color.fromARGB(255, 82, 82, 82)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(hint:  'Dsn.Ngembul, Ds.Kesamben, kec.kesamben. kab.Jombang, jawa timur', maxLine: 3, minLine: 1, controller: _alamatController),
              // MyTextField(
              //   controller: _alamatController,
              //   hint:
              //      ,
              //   obsecureText: false,
                
              //   textCapitalization: TextCapitalization.none,
              // ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  onTap: () {
                    addData(
                        int.parse(_nikController.text),
                        int.parse(_telpController.text),
                        _alamatController.text,
                        context);
                  },
                  color: const Color.fromARGB(255, 165, 177, 248),
                  child: Text(
                    'Selesai',
                    style: medium15.copyWith(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
