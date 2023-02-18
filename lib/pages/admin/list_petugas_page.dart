import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/pages/theme/style.dart';

class PetugasView extends StatelessWidget {
  const PetugasView({super.key});
  static String routesName = '/petugasView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'List Petugas',
          style: semiBold17.copyWith(color: Colors.grey[800], fontSize: 20),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
    );
  }
}
