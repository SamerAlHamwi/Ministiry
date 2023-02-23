import 'cached_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CircularImage extends StatelessWidget {
  final double radius;
  final File? image;
  final bool isNetworkImage;
  final String? imageUrl;

  /// toWorkOn : add shadow

   const CircularImage({Key? key,
    required this.radius,
    this.imageUrl,
    this.image,
   required this.isNetworkImage ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      child: ClipOval(
        child: isNetworkImage
            ? CachedImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
              )
            : image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
          'assets/images/placeholders/placeholder.jpg',
                    fit: BoxFit.fill,
                  ),
      ),
    );
  }
}
