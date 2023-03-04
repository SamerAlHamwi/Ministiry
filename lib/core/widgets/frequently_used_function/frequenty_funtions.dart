import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Notification/notification.dart';
import '../../utils/Navigation/Navigation.dart';
import '../../utils/shared_preferences/SharedPreferencesHelper.dart';
import '../dialogs/dialog_exit_app.dart';

class FrequentlyFunction {
  static Future<bool> showLogoutConfirmDialog(context,Widget destinationPage) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return DialogExitApp(
            title: 'logout_confirmation'.tr(),
            content: 'are_you_sure_you_want_to_logout'.tr(),
            onPressedYes: () {
              AppSharedPreferences.removeAccessToken();
              if(Messaging.token!=null){
              Messaging.deleteToken();}
              Navigation.pushAndRemoveUntil(destinationPage);
            },
            onPressedNo: () {
              Navigator.pop(context, false);
            },
          );
        });
  }
  static Duration convertSecondsToDuration(dynamic timeInSeconds) {
    //timeInSeconds =3600;
    int seconds = (timeInSeconds % 60).toInt();
    int minutes = ((timeInSeconds /60)%60).toInt();
    int hours = ((timeInSeconds/60)/60).toInt();
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
  static isValidNumber(String? value){
    if(value==null)
    {
      return false;
    }
    if (value.length<1){
      return false;
    }
    else {
      return true;
    }

  }
}
