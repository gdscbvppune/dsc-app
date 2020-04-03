import 'package:flutter/material.dart';

class ImageExpand extends StatelessWidget {
  final imageURL;
  ImageExpand({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'image',
            child: Image.network(
              imageURL,
            ),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}