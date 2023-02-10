import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {super.key,
      required this.mobileScafold,
      required this.tabletScafold,
      required this.desktopScafold});
  final Widget mobileScafold;
  final Widget tabletScafold;
  final Widget desktopScafold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth < 500) {
          return mobileScafold;
        } else if (constraint.maxWidth < 1100) {
          return tabletScafold;
        } else {
          return desktopScafold;
        }
      },
    );
  }
}
