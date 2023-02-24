import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  const FullscreenImage({super.key});

  static String routeName = '/fullscreenImage';

  @override
  Widget build(BuildContext context) {
    var imagePath = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Image.network(
        imagePath,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
