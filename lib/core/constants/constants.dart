import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String APP_NAME = 'app_name'.tr();

// Languages
String DEFAULT_LANGUAGE = 'ar';
const Map<String, Locale> LANGUAGES = {
  'ar': Locale('ar'),
  'en': Locale('en'),
};

enum NotificationsState { Unread, Read }

// Headers
const HEADER_LANGUAGE = 'Accept-Language';
const HEADER_AUTH = 'authorization';
const HEADER_CONTENT_TYPE = 'Content-Type';
const HEADER_ACCEPT = 'accept';

enum Gender { unspecified, male, female }

enum Positions { TOP, Bottom, LEFT, RIGHT }

enum NotificationType {
  NULL,
}
