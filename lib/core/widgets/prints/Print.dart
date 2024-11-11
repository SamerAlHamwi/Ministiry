import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/Keys.dart';
import '../../constants/app_colors.dart';

class Print {
  static showSnackBar(
      {required String message,
      AnimatedSnackBarType typeSnackBar = AnimatedSnackBarType.success}) {
    return AnimatedSnackBar.material(message, type: typeSnackBar)
        .show(Keys.navigatorKey.currentContext!);
  }

  static showErrorSnackBar(
      {required String message,
      AnimatedSnackBarType typeSnackBar = AnimatedSnackBarType.error}) {
    return AnimatedSnackBar.material(message, type: typeSnackBar)
        .show(Keys.navigatorKey.currentContext!);
  }

  static showQuestion(context,
      {String? title,
      String? subtitle,
      Widget? content,
      VoidCallback? btnOkOnPress,
      VoidCallback? btnCancelOnPress}) {
    AwesomeDialog(
      context: Keys.navigatorKey.currentContext!,
      // dialogType: DialogType.QUESTION,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
//          () {
//        // appController.sound = !appController.sound;
//        // appController.setSound(appController.sound);
//      },
      btnCancelText: 'Cancel'.tr(),
      btnOkText: 'Ok'.tr(),

      body: Column(
        children: [
          ListTile(
            title: Text(
              title ?? "",
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              subtitle ?? "",
              textAlign: TextAlign.start,
            ),
          ),
          content ?? const SizedBox.shrink(),
        ],
      ),
    ).show();
  }

  static showTransparency() {
    showDialog(
      barrierDismissible: false,
      context: Keys.navigatorKey.currentContext!,
      builder: (_) => Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: [
          Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: 100.0.w,
                height: 100.0.h,
                color: AppColors.primaryColor.withOpacity(0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.primaryColor,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
