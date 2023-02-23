import '../errors/base_error.dart';
import 'base_result_model.dart';

class BaseResponseModel<Result extends BaseResultModel> {
  Result? result;
  String? targetUrl;
  bool? success;
  BaseError? error;
  bool? unAuthorizedRequest;
  bool? bAbp;
  ServerError? serverError;

  BaseResponseModel(
      {this.result,
      this.targetUrl,
      this.success,
      this.serverError,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  BaseResponseModel.fromJson(
      {Map<String, dynamic>? json,
      Result Function(Map<String, dynamic>)? fromJson,
      bool isLaravel = false,
      BaseError? error}) {
    if (isLaravel) {
      fromLaravelJson(json, error, fromJson);
    } else {
      if (json == null) {
        if (error != null) {
          this.error = error;
          success = false;
        }
      } else {
        targetUrl = json['targetUrl'];
        success = json['success'] ?? false;
        serverError =
            json['error'] != null ? ServerError.fromJson(json['error']) : null;
        unAuthorizedRequest = json['unAuthorizedRequest'];
        bAbp = json['__abp'];
        this.error = error;

        if (fromJson != null) {
          if (json['result'] != null) {
            result = fromJson(json['result']);
          } else {
            if (success!) result = fromJson({});
          }
        }
      }
    }
  }

  void fromLaravelJson(
      Map<String, dynamic>? json, BaseError? error, dynamic fromJson) {
    if (json == null) {
      if (error != null) {
        this.error = error;
        success = false;
      }
    } else {
      success = json['isOk'] ?? false;
      if (json['message'] != null) {
        String errorMessage = json['message'] is String
            ? json['message']
            : json['message']["content"];
        int errorCode = json['message'] is String ? 0 : json['message']["code"];
        serverError = ServerError(message: errorMessage, code: errorCode);
      } else {
        serverError = null;
      }
      this.error = error;

      if (fromJson != null) {
        if (json['result'] != null) {
          result = fromJson(json);
        } else {
          if (success!) {
            result = fromJson({"da": "s"});
          }
        }
      }
    }
  }
}

class ServerError extends BaseResultModel {
  int? code;
  String? message;
  String? details;
  List<ValidationErrors>? validationErrors;

  ServerError({this.code, this.message, this.details, this.validationErrors});

  ServerError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
    if (json['validationErrors'] != null) {
      validationErrors = List.from(json['validationErrors'])
          .map((e) => ValidationErrors.fromJson(e))
          .toList();
      json['validationErrors'].forEach((v) {
        validationErrors!.add(ValidationErrors.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['message'] = message;
    data['details'] = details;
    if (validationErrors != null) {
      data['validationErrors'] =
          validationErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValidationErrors {
  String? message;
  List<String>? members;

  ValidationErrors({this.message, this.members});

  ValidationErrors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    members = json['members'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['members'] = members;
    return data;
  }
}
