import 'package:flutter/material.dart';
import '../pages/theme/style.dart';

class SquareTile extends StatelessWidget {
  String imagePath;
  void Function() onTap;
  String title;

  SquareTile(
      {super.key,
      required this.imagePath,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(100)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style:
                    semiBold17.copyWith(color: Colors.grey[700], fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
