import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/theme/style.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool obsecureText;
  final TextInputType? keyboardType;
  // ignore: prefer_typing_uninitialized_variables
  final suffix;
  // ignore: prefer_typing_uninitialized_variables
  final prefix;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormater;
  final TextCapitalization textCapitalization;

  MyTextField(
      {this.inputFormater,
      this.keyboardType,
      super.key,
      required this.hint,
      required this.obsecureText,
      this.controller,
      this.suffix,
      this.prefix,
      required this.textCapitalization});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07),
      child: SizedBox(
        height: 50,
        // width: 300,
        child: Form(
          // key: formKey,
          child: TextField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.bottom,
            controller: controller,
            obscureText: obsecureText,
            onChanged: (value) {},
            maxLines: 1,
            keyboardType: keyboardType,
            inputFormatters: inputFormater,
            textCapitalization: textCapitalization,
            style: medium15,
            // validator: validator,
            decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                hintText: hint,
                suffixIcon: suffix,
                hintStyle: medium15.copyWith(color: Colors.grey.shade500),
                contentPadding: const EdgeInsets.all(30),
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
