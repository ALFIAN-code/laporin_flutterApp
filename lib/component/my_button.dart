import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  void Function()? onTap;
  Color? color;
  Widget child;

  MyButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.child});
// MediaQuery.of(context).size.width * 0.85
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
