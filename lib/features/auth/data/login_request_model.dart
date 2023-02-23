
class LoginRequestModel
{
  String? userNameOrEmailAddress;
  String? password;
  bool? rememberClient;

  LoginRequestModel(
      {this.userNameOrEmailAddress, this.password, this.rememberClient});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    userNameOrEmailAddress = json['userNameOrEmailAddress'];
    password = json['password'];
    rememberClient = json['rememberClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userNameOrEmailAddress'] = this.userNameOrEmailAddress;
    data['password'] = this.password;
    data['rememberClient'] = this.rememberClient;
    return data;
  }

}