import 'package:ministry_minister_app/features/home_app/data/calls_list_response.dart';

import '../../../../core/api/core_models/base_result_model.dart';
import '../../../../core/api/core_models/empty_model.dart';
import '../../../../core/api/data_source/remote_data_source.dart';
import '../../../../core/api/http/api_urls.dart';
import '../../../../core/api/http/http_method.dart';

class CallsRepository {
  static Future<BaseResultModel> getCalls(
      {required dynamic requestData,}) async {
    return await RemoteDataSource.request<CallsListResponse>(
      converter: (json) => CallsListResponse.fromJson(json),
      method: HttpMethod.get,
      withAuthentication: true,
      queryParameters: requestData.toJson(),
      url: ApiURLs.getAllCalls,
    );
  }

}
