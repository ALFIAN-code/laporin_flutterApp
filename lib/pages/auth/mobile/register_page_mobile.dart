import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Services/auth_service.dart';
import '../../../component/my_button.dart';
import '../../../component/square_tile.dart';
import '../../../component/text_field.dart';
import '../../theme/style.dart';

// ignore: must_be_immutable
class RegisterPageMobile extends StatefulWidget {
  RegisterPageMobile(
      {super.key,
      required this.emailController,
      required this.hidePassword,
      required this.hideConfirmPassword,
      required this.passwordController,
      this.userRegister,
      this.onTap,
      required this.fullnameController,
      required this.passwordConfirmController});

  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final TextEditingController emailController;
  final TextEditingController fullnameController;
  bool hidePassword;
  bool hideConfirmPassword;
  final void Function()? userRegister;
  final void Function()? onTap;

  @override
  State<RegisterPageMobile> createState() => _RegisterPageMobileState();
}

class _RegisterPageMobileState extends State<RegisterPageMobile> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
              Container(
                height: deviceHeight * 0.25,
                padding: const EdgeInsets.symmetric(vertical: 40),
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
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              MyTextField(
                textCapitalization: TextCapitalization.none,
                // formKey: _emailFormKey,
                hint: 'Fullname',
                obsecureText: false,
                controller: widget.fullnameController,
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
                controller: widget.emailController,
              ),

              SizedBox(
                height: deviceHeight * 0.02,
              ),
              MyTextField(
                  textCapitalization: TextCapitalization.none,
                  // formKey: _passwordFormKey,
                  hint: 'Password',
                  obsecureText: widget.hidePassword,
                  controller: widget.passwordController,
                  suffix: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: (widget.hidePassword)
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          widget.hidePassword = !widget.hidePassword;
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
                  obsecureText: widget.hideConfirmPassword,
                  controller: widget.passwordConfirmController,
                  suffix: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: (widget.hideConfirmPassword)
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          widget.hideConfirmPassword =
                              !widget.hideConfirmPassword;
                        });
                      },
                    ),
                  )),

              SizedBox(
                height: deviceHeight * 0.02,
              ),
              //sign in button
              MyButton(
                onTap: widget.userRegister,
                color: const Color(0xffFF8515),
                child: Text(
                  'Register',
                  style: bold17.copyWith(color: Colors.white),
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
                          style: semiBold15.copyWith(color: Colors.grey[700])),
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
                      AuthService().signInWithGoogle(context);
                    },
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
