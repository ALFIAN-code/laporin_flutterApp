import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapor_in/component/utils.dart';
import 'package:lapor_in/firebase_options.dart';
import 'package:lapor_in/pages/admin/laporan_selseai.dart';
import 'package:lapor_in/pages/admin/list_petugas_page.dart';
import 'package:lapor_in/pages/auth/forgot_password_page.dart';
import 'package:lapor_in/pages/admin/dashboard.dart';
import 'package:lapor_in/pages/user/add_laporan.dart';
import 'package:lapor_in/pages/user/lengkapi_data.dart';
import 'auth_page.dart';
import 'pages/user/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDCXc5lclocm3RLaJwGBc88x-Lj07IJ6So',
            appId: '1:643979588576:web:b6db9b9cf4a58e87317185',
            messagingSenderId: '643979588576',
            projectId: 'laporin-89b57'));
  } else {
    await Firebase.initializeApp(
        name: 'lapor in', options: DefaultFirebaseOptions.currentPlatform);
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      title: 'Lapor in',
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      initialRoute: AuthPage.routesName,
      routes: {
        HomePage.routesName: (context) => const HomePage(),
        AuthPage.routesName: (context) => const AuthPage(),
        ForgotPasswordPage.routesName: (context) => const ForgotPasswordPage(),
        Dashboard.routesName: (context) => const Dashboard(),
        AddLaporan.routesName: (context) => const AddLaporan(),
        LengkapiData.routesName: (context) => const LengkapiData(),
        LaporanSelesai.routesName: (context) => const LaporanSelesai(),
        PetugasView.routesName: (context) => const PetugasView()
      },
    );
  }
}
