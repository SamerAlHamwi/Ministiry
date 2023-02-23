import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/shared_preferences/SharedPreferencesHelper.dart';
import 'constant.dart';

class AppTheme {
  AppTheme._();

  static const cardShadowColor = Color(0xFFd3d1d1);
  static const borderLine = Color(0xffc0c0c0);
  static const double iconSize = 20;
  static ThemeData appTheme = ThemeData(
    iconTheme: const IconThemeData(color: AppColors.black, size: iconSize),
    primaryColor: AppColors.primaryColor,
    fontFamily: AppSettings.appFont,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: _inputDecorationTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    cupertinoOverrideTheme: appThemeCupertino,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: AppColors.primaryColor,
          minimumSize: const Size(double.infinity, 44),
          textStyle: button),
    ),
    primarySwatch: Colors.green,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      primary: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      side: const BorderSide(color: AppColors.primaryColor, width: 1),
    )),
  );

  static CupertinoThemeData appThemeCupertino =  CupertinoThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: CupertinoTextThemeData(
          textStyle: bodyText1,
          actionTextStyle: bodyText1,
          dateTimePickerTextStyle: bodyText1,
          navActionTextStyle: bodyText1,
          navLargeTitleTextStyle: bodyText1,
          navTitleTextStyle: bodyText1,
          pickerTextStyle: bodyText1,
          tabLabelTextStyle: bodyText1,
          primaryColor: AppColors.white)
      // textTheme: _textTheme,
      );

  static const _appBarTheme = AppBarTheme(
    color: AppColors.primaryColor,
    shadowColor: cardShadowColor,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.white, size: iconSize),
    actionsIconTheme:
        IconThemeData(color: AppColors.primaryColor, size: iconSize),
    centerTitle: true,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.all(8),
    fillColor: Colors.transparent,
    filled: true,
    prefixIconColor: AppColors.primaryColor,
  );

  static final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(8),
    fillColor: AppColors.lightGrey,
    filled: true,
    prefixIconColor: AppColors.grey,
    disabledBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.2, color:AppColors.darkGrey),
    ),
    border: AppStyles.inputDecorationBorder,
    enabledBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.4, color: AppColors.lightBlueColor),
    ),
    focusedBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.lightBlueColor, width: 1),
    ),
    errorBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.transparent, width: 1),
    ),
  );

  static final _textTheme = TextTheme(
      bodyText1: bodyText1,
      bodyText2: bodyText2,
      button: button,
      subtitle1: subtitle1,
      subtitle2: subtitle2,
      headline5: headline5,
      headline6: headline6);

  static TextStyle bodyText1 = TextStyle(
      fontSize: 14,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit",
      color: AppColors.black);
  static TextStyle bodyText2 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit");
  static TextStyle bodyText3 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily:
          AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit-Regular",
      color: AppColors.white); // default for Text() widget
  static TextStyle button = TextStyle(
      fontSize: 12,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit");
  static TextStyle subtitle1 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: AppSharedPreferences.lang == "ar"
          ? "Tajawal"
          : "Outfit"); // default for ListTile(title:) widget style
  static TextStyle subtitle2 = TextStyle(
      fontSize: 12,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit");
  static TextStyle headline4 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit",
      color: AppColors.white);
  static TextStyle headline3 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit",
      color: AppColors.black);

  static TextStyle headline5 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit",
      color: AppColors.white);
  static TextStyle headline6 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: AppSharedPreferences.lang == "ar" ? "Tajawal" : "Outfit",
      color: AppColors.primaryColor);

//Flex Text
  static TextStyle _getFlexBodyText(double rate, double h, double w) {
    if (w < h) {
      return TextStyle(
          fontSize: w * rate,
          color: AppColors.white,
          fontFamily: "Outfit-Regular");
    } else {
      return TextStyle(
          fontSize: h * rate,
          color: AppColors.white,
          fontFamily: "Outfit-Regular");
    }
  }

  static TextStyle _getFlexHeadLineText(double rate, double h, double w) {
    if (w < h) {
      return TextStyle(
          fontSize: w * rate,
          color: AppColors.white,
          fontFamily: "Outfit",
          fontWeight: FontWeight.bold);
    } else {
      return TextStyle(
          fontSize: h * rate,
          color: AppColors.white,
          fontFamily: "Outfit",
          fontWeight: FontWeight.bold);
    }
  }

  static TextStyle flexHeadline1(double h, double w) =>
      _getFlexHeadLineText(0.9, h, w);

  static TextStyle flexHeadline2(double h, double w) =>
      _getFlexHeadLineText(0.8, h, w);

  static TextStyle flexHeadline3(double h, double w) =>
      _getFlexHeadLineText(0.7, h, w);

  static TextStyle flexHeadline4(double h, double w) =>
      _getFlexHeadLineText(0.6, h, w);

  static TextStyle flexHeadline5(double h, double w) =>
      _getFlexHeadLineText(0.5, h, w);

  static TextStyle flexBodyText5(double h, double w) =>
      _getFlexBodyText(0.4, h, w);

  static TextStyle flexBodyText4(double h, double w) =>
      _getFlexBodyText(0.3, h, w);

  static TextStyle flexBodyText3(double h, double w) =>
      _getFlexBodyText(0.2, h, w);

  static TextStyle flexBodyText2(double h, double w) =>
      _getFlexBodyText(0.15, h, w);

  static TextStyle flexBodyText1(double h, double w) =>
      _getFlexBodyText(0.1, h, w);
}
