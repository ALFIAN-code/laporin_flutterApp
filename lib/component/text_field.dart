import 'package:flutter/material.dart';
import 'package:lapor_in/style.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool obsecureText;
  // ignore: prefer_typing_uninitialized_variables
  final suffix;
  // ignore: prefer_typing_uninitialized_variables
  final prefix;
  // final Key formKey;
  // Key keyField = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  String? Function(String?)? validator;

  MyTextField({
    super.key,
    required this.hint,
    required this.obsecureText,
    this.controller,
    this.suffix,
    this.prefix,
    // this.validator,
    // required this.formKey
  });
// MediaQuery.of(context).size.width * 0.08
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07),
      child: SizedBox(
        height: 50,
        // width: 300,
        child: Form(
          // key: formKey,
          child: TextFormField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.bottom,
            controller: controller,
            obscureText: obsecureText,
            onChanged: (value) {},
            maxLines: 1,
            // validator: validator,
            decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                hintText: hint,
                suffixIcon: suffix,
                hintStyle: medium17,
                contentPadding: EdgeInsets.all(30),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(100)))),
          ),
        ),
      ),
    );
  }
}
