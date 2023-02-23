import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';

class UnauthorizedError extends HttpError {
  String message ='Unauthorized Error'.tr();
}