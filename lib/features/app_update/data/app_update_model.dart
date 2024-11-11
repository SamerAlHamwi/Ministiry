

import '../../../core/api/core_models/base_result_model.dart';

class AppUpdateModel extends BaseResultModel {
  String? creationTime;
  int? type;
  int? buildNumber;
  String? versionNumber;
  String? appFilePath;
  String? typeName;
  int? id;

  AppUpdateModel({
    this.creationTime,
    this.type,
    this.buildNumber,
    this.versionNumber,
    this.appFilePath,
    this.typeName,
    this.id,
  });

  AppUpdateModel.fromJson(Map<String, dynamic> json) {
    creationTime = json['creationTime'] as String?;
    type = json['type'] as int?;
    buildNumber = json['buildNumber'] as int?;
    versionNumber = json['versionNumber'] as String?;
    appFilePath = json['appFilePath'] ?? ' ';
    typeName = json['typeName'] as String?;
    id = json['id'] as int?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['creationTime'] = creationTime;
    json['type'] = type;
    json['buildNumber'] = buildNumber;
    json['versionNumber'] = versionNumber;
    json['appFilePath'] = appFilePath;
    json['typeName'] = typeName;
    json['id'] = id;
    return json;
  }
}