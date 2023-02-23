import 'package:cached_network_image/cached_network_image.dart';
import 'image_place_holder.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final Widget? placeholder;

  const CachedImage({Key? key, required this.imageUrl, this.fit, this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl??'',
      fit: fit ?? BoxFit.cover,
      placeholder: (BuildContext context, _) {
        return placeholder ?? ImagePlaceHolder();
      },
    );
  }
}
