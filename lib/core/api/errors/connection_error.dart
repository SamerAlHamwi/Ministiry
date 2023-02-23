import 'package:easy_localization/easy_localization.dart';

import 'base_error.dart';


class ConnectionError extends BaseError {
  static String errorMessage = 'ConnectionError'.tr();
  String message = errorMessage;

  List<Object> get props => [];
}