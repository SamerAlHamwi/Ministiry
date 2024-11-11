

class AppUpdateRequestModel
{
  int? appType;
  int? buildNumber;

  AppUpdateRequestModel({this.appType, this.buildNumber});

  AppUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    appType = json['appType'];
    buildNumber = json['buildNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appType'] = appType;
    data['buildNumber'] = buildNumber;
    return data;
  }

}