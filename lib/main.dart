import 'package:flutter/material.dart';
import 'package:lapor_in/component/snackbar.dart';
import 'package:lapor_in/pages/forgot_password_page.dart';
import '../pages/auth_page.dart';
import '../pages/home_page.dart';
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
      home: const AuthPage(),
      title: 'Lapor in',
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      initialRoute: AuthPage.routesName,
      routes: {
        HomePage.routesName: (context) => HomePage(),
        AuthPage.routesName: (context) => const AuthPage(),
        ForgotPasswordPage.routesName: (context) => const ForgotPasswordPage()
      },
    );
  }
}
