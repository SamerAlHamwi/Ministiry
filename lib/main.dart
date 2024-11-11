

import 'dart:io';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ministry_minister_app/features/app_update/presentation/check_update_screen.dart';
import 'package:ministry_minister_app/features/auth/presentation/pages/login_page.dart';
import 'package:ministry_minister_app/features/home_app/presentation/pages/home_app.dart';

import 'core/Notification/notification.dart';
import 'core/constants/Keys.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_settings.dart';
import 'core/constants/app_theme.dart';
import 'core/constants/constants.dart';
import 'core/notification/data/fcm_notification_model.dart';
import 'core/notification/domin/notification_middleware.dart';
import 'core/notification/local_notifications_service.dart';
import 'core/notification/signal_r.dart';
import 'core/utils/service_locator/service_locator.dart';
import 'core/utils/shared_preferences/SharedPreferencesHelper.dart';
import 'features/app_update/presentation/app_update_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await AppSharedPreferences.init();

  if (Platform.isAndroid || Platform.isIOS) await Firebase.initializeApp();
  await LocalNotificationService().init();
  await Messaging.initFCM();
  if (AppSharedPreferences.hasAccessToken) {
    await SignalR().start(onReceived: (data) {
      var notification =
          FCMNotificationModel.fromSignalR(data as Map<String, dynamic>);
      NotificationMiddleware.onRceived(notification);
    });
  }

  ServiceLocator.registerModels();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: LANGUAGES.values.toList(),
      path: 'assets/locales',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      saveLocale: true,
      child: Phoenix(
          child: ScreenUtilInit(
        designSize: const Size(100, 100),
        builder: (BuildContext context, Widget? child) => const MyApp(),
      )),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.appTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        builder: (context) => PlatformApp(
          navigatorKey: Keys.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: LANGUAGES.values.toList(),
          builder: EasyLoading.init(),
          locale: context.locale,
          title: AppSettings.appName,
          // home: const CheckUpdateScreen(),
          home: AppSharedPreferences.hasAccessToken ? const HomeApp() : const LoginPage(),
          material: (_, __) => MaterialAppData(
            scrollBehavior: AppScrollBehavior(),
            theme: AppTheme.appTheme,
            debugShowCheckedModeBanner: AppSettings.isDebug,
          ),
          cupertino: (_, __) => CupertinoAppData(
            scrollBehavior: AppScrollBehavior(),
            theme: AppTheme.appThemeCupertino,
            debugShowCheckedModeBanner: AppSettings.isDebug,
          ),
        ),
      ),
    );
  }
}
