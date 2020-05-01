import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            child: CachedNetworkImage(
              imageUrl: imageURL,
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
