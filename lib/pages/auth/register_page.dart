import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../Services/auth_service.dart';
import '../../component/error_dialog.dart';
import '../../component/my_button.dart';
import '../../component/square_tile.dart';
import '../../component/text_field.dart';
import '../theme/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  static String routesName = '/register';
  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var navigatorkey = GlobalKey<NavigatorState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  // final TextEditingController _confirmPasswordController =
  //     TextEditingController();
  // final Key _emailFormKey = GlobalKey<FormState>();
  // final Key _passwordFormKey = GlobalKey<FormState>();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  //function for add details info to database
  postDetailsToFirestore(
      {required String email,
      required String role,
      required String password,
      required String fullname}) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'fullname': fullname.toUpperCase(),
      'email': _emailController.text,
      'password': password,
      'role': role
    });
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //function for user register and add details using postDetailsToFirestore
  void userRegister() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff8CCD00),
            ),
          );
        });
    try {
      if (passwordConfirm()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) => postDetailsToFirestore(
                fullname: _fullnameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                role: 'user'));
      }

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // navigatorkey.currentState!.pop();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // navigatorkey.currentState!.pop();
      if (e.code == 'email-already-in-use') {
        errorDialog(
            title: 'email already in use',
            content: e.message.toString(),
            context: context);
      } else if (e.code == 'invalid-email') {
        errorDialog(
            title: 'invalid email',
            content: e.message.toString(),
            context: context);
      } else if (e.code == 'weak-password') {
        errorDialog(
            title: 'weak password',
            content: e.message.toString(),
            context: context);
      } else if (_fullnameController.text.isEmpty) {
        errorDialog(
            title: 'Fullname field cannot be empty',
            content: '',
            context: context);
      } else if (_emailController.text.isEmpty) {
        errorDialog(
            title: 'email field cannot be empty',
            content: '',
            context: context);
      } else if (_passwordController.text.isEmpty) {
        errorDialog(
            title: 'password field cannot be empty',
            content: '',
            context: context);
      }
    }
  }

  //function for confirm user password
  bool passwordConfirm() {
    if (_passwordController.text == _passwordConfirmController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Color(0xffFFB247),
    //     statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Color(0xffFFB247)),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Hero(
                  tag: 'leading',
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(100)),
                        gradient: LinearGradient(
                            colors: [Color(0xffFFB247), Color(0xffFFEBAF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: SvgPicture.asset(
                      'lib/images/user.svg',
                      height: deviceHeight * 0.16,
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  width: double.infinity,
                  child: Text(
                    'Register',
                    style: bold40.copyWith(
                      color: const Color(0xff575151),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                  textCapitalization: TextCapitalization.none,
                  hint: 'Fullname',
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  controller: _fullnameController,
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                  textCapitalization: TextCapitalization.none,
                  // formKey: _emailFormKey,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  controller: _emailController,
                ),

                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                    textCapitalization: TextCapitalization.none,
                    // formKey: _passwordFormKey,
                    hint: 'Password',
                    obsecureText: _hidePassword,
                    controller: _passwordController,
                    suffix: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: (_hidePassword)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      ),
                    )),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                MyTextField(
                    textCapitalization: TextCapitalization.none,
                    hint: 'confirm Password',
                    obsecureText: _hideConfirmPassword,
                    controller: _passwordConfirmController,
                    suffix: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: (_hideConfirmPassword)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _hideConfirmPassword = !_hideConfirmPassword;
                          });
                        },
                      ),
                    )),

                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                //sign in button
                Hero(
                  tag: 'button',
                  child: MyButton(
                    onTap: userRegister,
                    color: const Color(0xffFF8515),
                    child: Text(
                      'Register',
                      style: bold17.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                //dont have an account? register
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('have an account? ',
                        style: medium15.copyWith(
                          color: Colors.grey[600],
                        )),
                    TextButton(
                        onPressed: widget.onTap,
                        // () {
                        //   // Navigator.pushReplacementNamed(
                        //   //     context, LoginPage.routesName);

                        // },
                        child: Text(
                          'sign in',
                          style: medium15,
                        )),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Or Login With',
                            style:
                                semiBold15.copyWith(color: Colors.grey[700])),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),
                ),
                //google & facebook icon
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      title: 'Google',
                      imagePath: 'lib/images/google.png',
                      onTap: () {
                        AuthService().signInWithGoogle();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
