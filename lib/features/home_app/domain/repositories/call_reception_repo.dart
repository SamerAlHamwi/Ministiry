
import '../../../../core/api/core_models/base_result_model.dart';
import '../../../../core/api/core_models/empty_model.dart';
import '../../../../core/api/data_source/remote_data_source.dart';
import '../../../../core/api/http/api_urls.dart';
import '../../../../core/api/http/http_method.dart';
import '../../data/notify_screen_model.dart';


class CallReceptionRepo {

  static Future<BaseResultModel> notifyScreeen(NotifyScreenModel notifyScreenModel) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (json) => EmptyModel.fromJson(json),
      data: notifyScreenModel.toJson(),
      method: HttpMethod.post,
      withAuthentication: true,
      url: ApiURLs.notitfyScreenUrl,
    );
  }
  static Future<BaseResultModel> CancleCallRequest(int callId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (json) => EmptyModel.fromJson(json),
      data: {"id":callId},
      method: HttpMethod.put,
      withAuthentication: true,
      url: ApiURLs.CancleCallRequestUrl,
    );
  }



}
