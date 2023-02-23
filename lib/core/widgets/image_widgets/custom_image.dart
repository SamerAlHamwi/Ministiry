import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cached_image.dart';
import 'image_place_holder.dart';

class CustomImage extends StatelessWidget {
  final double? cornerRadius;
  final double? width;
  final double? height;
  final String? image;
  final Widget? placeHolder;
  final bool isNetworkImage;
  final BoxDecoration? decoration;
  final Color? color;
  final BoxFit? fit;
  final bool? svg;

  const CustomImage._(
      {this.cornerRadius,
      this.image,
      this.width,
      this.height,
      this.placeHolder,
      this.isNetworkImage = true,
      this.decoration,
      this.color,
      this.fit,
      this.svg});

  factory CustomImage.circular(
          {required double radius,
          String? image,
          Widget? placeHolder,
          BoxDecoration? decoration,
          isNetworkImage = true,
          Color? color,
          BoxFit? fit,
          svg = false}) =>
      CustomImage._(
        image: image,
        cornerRadius: radius,
        height: radius,
        width: radius,
        isNetworkImage: isNetworkImage,
        svg: svg,
        placeHolder: placeHolder,
        decoration: decoration,
        color: color,
        fit: fit,
      );

  factory CustomImage.rectangle({
    double cornerRadius = 0.0,
    @required String? image,
    double? width,
    double? height,
    Widget? placeHolder,
    BoxDecoration? decoration,
    BoxFit? fit,
    Color? color,
    isNetworkImage = true,
    svg = false,
  }) =>
      CustomImage._(
        image: image,
        cornerRadius: cornerRadius,
        height: height,
        width: width,
        color: color,
        isNetworkImage: isNetworkImage,
        placeHolder: placeHolder ?? Container(),
        decoration: decoration ?? const BoxDecoration(),
        fit: fit ?? BoxFit.contain,
        svg: svg,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius!),
        child: image == null
            ? ImagePlaceHolder()
            : isNetworkImage == true
                ? CachedImage(
                    imageUrl: image!,
                    placeholder: placeHolder,
                    fit: fit ?? BoxFit.cover,
                  )
                : svg!
                    ? SvgPicture.asset(image!,color: color,)
                    : Image.asset(
                        image!,
                        fit: BoxFit.fill,
                        color: color,
                      ),
      ),
    );
  }
}
