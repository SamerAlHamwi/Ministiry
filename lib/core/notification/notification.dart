
import 'package:flutter/foundation.dart';
import 'package:flutter_fcm/flutter_fcm.dart';
import '../constants/Keys.dart';
import '../utils/shared_preferences/SharedPreferencesHelper.dart';
import 'data/fcm_notification_model.dart';
import 'domin/cubit/notification_cubit.dart';
import 'domin/notification_middleware.dart';

class Messaging {
  static String? token;

  static deleteToken() {
    Messaging.token = null;
    FCM.deleteRefreshToken();
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationReceived(RemoteMessage message) async {
    await Firebase.initializeApp();
    var notification = FCMNotificationModel.fromJson(message.data);
    NotificationMiddleware.onRceived(notification);
  }

  @pragma('vm:entry-point')
  static initFCM() async {
    try {
      await FCM.initializeFCM(
        withLocalNotification: true,
        navigatorKey: Keys.navigatorKey,
        onNotificationReceived: onNotificationReceived,
        onNotificationPressed: (Map<String, dynamic> data) {
          var notification = FCMNotificationModel.fromJson(data);
          NotificationMiddleware.forward(notification);
        },
        onTokenChanged: (String? token) async{
          if (token != null) {
            Messaging.token = token;
            if (AppSharedPreferences.hasAccessToken) {
             await NotificationCubit.updateFCMToken(Messaging.token);
              if (kDebugMode) {
                print('FCM Token  $token');
              }
            }
          }
        },
        icon: 'ic_launcher',
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
