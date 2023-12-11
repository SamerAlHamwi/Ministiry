import 'package:ministry_minister_app/core/api/core_models/base_result_model.dart';

class CallsListResponse extends ListResultModel<Call> {
  @override
  late List<Call> list;
  int? totalCount;

  CallsListResponse({required this.list, this.totalCount});

  CallsListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      list = <Call>[];
      json['items'].forEach((v) {
        list.add(Call.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = list.map((v) => v.toJson()).toList();
    data['totalCount'] = totalCount;
    return data;
  }
}

class Call {
  int? id;
  String? callRequesterName;
  String? creationTime;
  String? orderNumber;
  String? screenJoinedDate;
  String? screenLeaveDate;
  int? numberOfCallMinutes;
  int? callStatus;
  String? link;
  String? room;
  Leader? leader;
  Leader? screen;

  Call(
      {this.id,
      this.screenJoinedDate,
      this.creationTime,
      this.screenLeaveDate,
      this.numberOfCallMinutes,
      this.callRequesterName,
      this.callStatus,
      this.link,
      this.room,
      this.leader,
      this.screen});

  Call.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    screenJoinedDate = json['screenJoinedDate'];
    creationTime = json['creationTime'];
    screenLeaveDate = json['screenLeaveDate'];
    numberOfCallMinutes = json['numberOfCallMinutes'];
    callStatus = json['callStatus'];
    callRequesterName = json['callRequesterName'];
    link = json['link'];
    room = json['room'];
    leader = json['leader'] != null ? Leader.fromJson(json['leader']) : null;
    screen = json['screen'] != null ? Leader.fromJson(json['screen']) : null;
    orderNumber = json['orderNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['screenJoinedDate'] = screenJoinedDate;
    data['creationTime'] = creationTime;
    data['screenLeaveDate'] = screenLeaveDate;
    data['numberOfCallMinutes'] = numberOfCallMinutes;
    data['callStatus'] = callStatus;
    data['callRequesterName'] = callRequesterName;
    data['link'] = link;
    data['room'] = room;
    if (leader != null) {
      data['leader'] = leader!.toJson();
    }
    if (screen != null) {
      data['screen'] = screen!.toJson();
    }
    return data;
  }
}

class Leader {
  int? id;
  String? userName;
  String? name;
  String? userPosition;
  String? surname;
  String? emailAddress;
  bool? isActive;
  String? fullName;
  String? lastLoginTime;
  String? creationTime;
  int? userType;
  int? unitId;
  int? departmentId;
  int? ministryId;

  //List<String>? roleNames;

  Leader({
    this.id,
    this.userName,
    this.name,
    this.userPosition,
    this.surname,
    this.emailAddress,
    this.isActive,
    this.fullName,
    this.lastLoginTime,
    this.creationTime,
    this.userType,
    this.unitId,
    this.departmentId,
    this.ministryId,
    //this.roleNames
  });

  Leader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    name = json['name'];
    userPosition = json['userPosition'];
    surname = json['surname'];
    emailAddress = json['emailAddress'];
    isActive = json['isActive'];
    fullName = json['fullName'];
    lastLoginTime = json['lastLoginTime'];
    creationTime = json['creationTime'];
    userType = json['userType'];
    unitId = json['unitId'];
    departmentId = json['departmentId'];
    ministryId = json['ministryId'];
    //roleNames = json['roleNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['name'] = name;
    data['userPosition'] = userPosition;
    data['surname'] = surname;
    data['emailAddress'] = emailAddress;
    data['isActive'] = isActive;
    data['fullName'] = fullName;
    data['lastLoginTime'] = lastLoginTime;
    data['creationTime'] = creationTime;
    data['userType'] = userType;
    data['unitId'] = unitId;
    data['departmentId'] = departmentId;
    data['ministryId'] = ministryId;
    //data['roleNames'] = roleNames;
    return data;
  }
}
