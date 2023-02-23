import 'package:easy_localization/easy_localization.dart';

import '../core_models/base_result_model.dart';

abstract class BaseError extends BaseResultModel {
  String message = 'BaseError Message'.tr();
}
