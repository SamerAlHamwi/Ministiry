import '../../../core/api/core_models/base_result_model.dart';

class LoginResponseModel extends BaseResultModel{
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  int? userId;
  int? userType;

  LoginResponseModel(
      {this.accessToken,
        this.encryptedAccessToken,
        this.expireInSeconds,
        this.userId,
        this.userType
      });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    encryptedAccessToken = json['encryptedAccessToken'];
    expireInSeconds = json['expireInSeconds'];
    userId = json['userId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['encryptedAccessToken'] = this.encryptedAccessToken;
    data['expireInSeconds'] = this.expireInSeconds;
    data['userId'] = this.userId;
    data['userType'] = this.userType;
    return data;
  }
}