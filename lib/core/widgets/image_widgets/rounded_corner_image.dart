import 'cached_image.dart';
import 'package:flutter/material.dart';

import 'image_place_holder.dart';

class RoundedCornerImage extends StatelessWidget {
  /// toWorkOn : set default value for the cornerRadius
  /// toWorkOn : add shadow
  final double cornerRadius;
  final double? width;
  final double? height;
  final String? image;
  final String? placeHolder;
  final bool isNetworkImage;
  final BoxFit? fit;

   const RoundedCornerImage({Key? key,
    required this.cornerRadius,
    this.image,
    this.width,
    this.height,
    this.placeHolder,
    this.isNetworkImage = true,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child:  image ==null?ImagePlaceHolder() : isNetworkImage == true
              ? CachedImage(
                  imageUrl: image!,
                )
              : Image.asset(
                  image!,
                  fit: fit ?? BoxFit.cover,
                )),
    );
  }
}
