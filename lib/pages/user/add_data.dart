// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/pages/user/home_page.dart';
import 'package:lapor_in/pages/theme/style.dart';
import '../../../component/text_field.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController _fullnamecontroller = TextEditingController();

  final TextEditingController _nikController = TextEditingController();

  final TextEditingController _telpController = TextEditingController();

  // final user = FirebaseAuth.instance.currentUser;

  // Future<bool> dataChecker() async {
  //   DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
  //       .instance
  //       .collection('user')
  //       .doc(user!.uid)
  //       .get();

  //     if (document.exists) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/add_user.jpg',
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  'Add data for your account',
                  textAlign: TextAlign.center,
                  style: bold25.copyWith(color: Colors.grey[700]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                textCapitalization: TextCapitalization.words,
                // formKey: _emailFormKey,
                hint: 'Fullname',
                obsecureText: false,
                controller: _fullnamecontroller,
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              MyTextField(
                textCapitalization: TextCapitalization.none,
                // formKey: _emailFormKey,
                hint: 'NIK',
                keyboardType: TextInputType.number,
                obsecureText: false,
                controller: _nikController,
                inputFormater: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              MyTextField(
                textCapitalization: TextCapitalization.none,
                // formKey: _emailFormKey,
                hint: 'telp',
                obsecureText: false,
                keyboardType: TextInputType.number,
                controller: _telpController,
                inputFormater: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              MyButton(
                  onTap: () {
                    // addUserData(
                    //     fullname: _fullnamecontroller.text,
                    //     uid: user!.uid.toString(),
                    //     email: user!.email.toString(),
                    //     nik: int.parse(_nikController.text),
                    //     telp: int.parse(_telpController.text));
                    const HomePage();
                  },
                  color: const Color(0xffFF4F5A),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add Data',
                        style: bold17.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
