import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class AppStyles {
  AppStyles._();

  static const Offset offset = Offset(5, 5);
  static const double blurRadius = 10;
  static const Color bottomShadowColor = Color(0x26234395);
  static const Color topShadowColor = Colors.white60;

  static List<BoxShadow> defaultShadow = [
    const BoxShadow(
      offset: offset,
      blurRadius: blurRadius,
      color: bottomShadowColor,
    ),
    BoxShadow(
      offset: Offset(-offset.dx, -offset.dx),
      blurRadius: blurRadius,
      color: topShadowColor,
    ),
  ];

  static List<BoxShadow> containerShadow = [
    const BoxShadow(
        color: Color(0xa8c0c0c0),
        offset: Offset(2.1, 2.1),
        blurRadius: AppDimension.defaultRadius)
  ];

// Radius
  static BorderRadius borderRadius =
      BorderRadius.circular(AppDimension.defaultRadius);
  static BorderRadius borderBoxRadius =
      BorderRadius.circular(AppDimension.boxRadius);
  static BorderRadius circularBorder =
      const BorderRadius.all(Radius.circular(AppDimension.defaultRadius));

// Decoration
  static BoxDecoration mainBoxDecoration = BoxDecoration(
      color: AppColors.grey,
      borderRadius: BorderRadius.circular(AppDimension.pageRadius));
  static BoxDecoration pageBoxDecoration = BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimension.pageRadius),
      boxShadow: containerShadow);
  static BoxDecoration boxDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: borderBoxRadius,
  );
  static BoxDecoration defaultBoxDecoration = BoxDecoration(
      borderRadius: borderBoxRadius,
      border: Border.all(color: Colors.grey.shade300, width: 1));
//      color: AppColors.white,
//      borderRadius:
//      borderBoxRadius,
//      boxShadow: containerShadow,
//  );
  static BoxDecoration buttonBoxDecoration = BoxDecoration(
    boxShadow: containerShadow,
    borderRadius: borderBoxRadius,
  );
  static BoxDecoration iconBoxDecoration = BoxDecoration(
    color: AppColors.grey,
    boxShadow: containerShadow,
    borderRadius: borderBoxRadius,
  );

  static RoundedRectangleBorder roundedRectangleBorder =
      RoundedRectangleBorder(borderRadius: borderRadius);

// Border

  static OutlineInputBorder inputDecorationBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder outLineBorder = OutlineInputBorder(
    borderRadius: circularBorder,
    borderSide: BorderSide.none,
  );

  static const SystemUiOverlayStyle defaultOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
