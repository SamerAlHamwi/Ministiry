import 'package:flutter/cupertino.dart';

class AppDimension {
  AppDimension._();

  /// Responsive Sizes
  static const double desktopWidth = 1100;
  static const double tabletWidth = 650;

  /// Decoration Sizes
  static const double defaultPadding = 10.0;
  static const double defaultRadius = 5.0;
  static const double pageRadius = 20.0;
  static const double boxRadius = 8.0;
  static double screenWidth(BuildContext context)
  {
    return MediaQuery.of(context).size.width;
  }
  static double screenHeight(BuildContext context)
  {
    return MediaQuery.of(context).size.height;
  }
}
