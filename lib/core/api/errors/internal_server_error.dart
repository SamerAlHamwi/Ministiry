import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';

class InternalServerError extends HttpError {
  String message ='InternalServerError'.tr();
}