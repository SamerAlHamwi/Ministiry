import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static const List requestColors = [
    Color(0x59cc38a1),
    Color(0x59386ccc),
    Color(0x5938cc44),
    Color(0x59cc3838),
    Color(0x59fffb1f),
  ];

  static const Map<String, Locale> languages = {
    'ar': Locale('ar'),
    'en': Locale('en'),
  };
  static Locale defaultLocal = Locale("en");

  static getDefaultLanguage() async {
    List? languages = await Devicelocale.preferredLanguages;
    defaultLocal = Locale(languages!.elementAt(0).toString().split("-")[0]);
    return defaultLocal;
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  /// just to provide scroll to web and windows
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
