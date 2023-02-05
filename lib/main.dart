import 'package:flutter/material.dart';
import 'package:lapor_in/component/snackbar.dart';
import 'package:lapor_in/pages/auth/auth_page.dart';
import 'package:lapor_in/pages/auth/forgot_password_page.dart';
import 'package:lapor_in/pages/dashboard/admin_dasboard.dart';
import 'package:lapor_in/pages/dashboard/petugas_dasboard.dart';
import 'pages/user/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      title: 'Lapor in',
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      initialRoute: AuthPage.routesName,
      routes: {
        HomePage.routesName: (context) => const HomePage(),
        AuthPage.routesName: (context) => AuthPage(),
        ForgotPasswordPage.routesName: (context) => const ForgotPasswordPage(),
        PetugasDashboard.routesName: (context) => const PetugasDashboard(),
        AdminDashboard.routesName: (context) => const AdminDashboard()
      },
    );
  }
}
