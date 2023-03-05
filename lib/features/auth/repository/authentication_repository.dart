import 'package:flutter/foundation.dart';

import '../../../core/api/core_models/base_result_model.dart';
import '../../../core/api/data_source/remote_data_source.dart';
import '../../../core/api/http/api_urls.dart';
import '../../../core/api/http/http_method.dart';
import '../../../core/notification/domin/cubit/notification_cubit.dart';
import '../../../core/notification/notification.dart';
import '../../../core/utils/shared_preferences/SharedPreferencesHelper.dart';
import '../../../core/widgets/prints/Print.dart';
import '../data/login_request_model.dart';
import '../data/login_response_model.dart';

class AuthenticationRepository {
  static Future<BaseResultModel> authenticateLogIn(
      LoginRequestModel loginRequestModel) async {
    final res = await RemoteDataSource.request<LoginResponseModel>(
      converter: (json) => LoginResponseModel.fromJson(json),
      method: HttpMethod.post,
      data: loginRequestModel.toJson(),
      withAuthentication: false,
      url: ApiURLs.loginUrl,
    );
    afterLogin(res);
    return res;
  }

  static Future<void> afterLogin(LoginResponseModel loginResponse) async {
    await Messaging.initFCM();
    AppSharedPreferences.accessToken = loginResponse.accessToken!;
    if (kDebugMode) {
      print(Messaging.token);
    }
    bool res = await NotificationCubit.updateFCMToken(Messaging.token);
    if (Messaging.token == null) {
      Print.showSnackBar(
        message: 'Your device is not supported by Google services',
      );
    } else {
      if (res == false) {
        Print.showErrorSnackBar(
            message: 'Error occurred while sending fcm token');
        AppSharedPreferences.clearForLogOut();
        return;
      }
    }
  }
}
