// import 'package:animated_snack_bar/animated_snack_bar.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../../../../api/core_models/base_response_model.dart';
// import '../../../../api/data_source/remote_data_source.dart';
// import '../../../../api/errors/base_error.dart';
// import '../../../../api/http/api_urls.dart';
// import '../../../../api/http/http_method.dart';
// import '../../../../notification/data/fcm_notification_model.dart';
// import '../../../../widgets/prints/Print.dart';
// import '../../../gps/gps.dart';
// import '../../../jwt/jwt.dart';
// import '../../../shared_preferences/SharedPreferencesHelper.dart';
// import '../../video_meeting_service.dart';
// import '../../data/action_meeting_model.dart';
// import '../../data/meeting_response_model.dart';
//
// class MeetingRepository {
//   static Future<BaseResultModel> requestMeeting(
//       MeetingRequestModel model) async {
//     AppSharedPreferences.lastCall = model.toJson();
//
//     try {
//       Position position = await GPS.determinePosition();
//       model.latitude = position.latitude;
//       model.longitude = position.longitude;
//     } catch (e) {}
//
//     NotificationCubit.startSignalR();
//     var res = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: model.toJson(),
//         url: ApiURLs.request_video_meeting);
//
//     if (res is MeetingResponseModel) {
//       print(AppSharedPreferences.isInCall);
//       model.oldMeetingId = res.id;
//
//       Future.delayed(Duration(seconds: 15)).then((value) {
//         if (!AppSharedPreferences.isInCall) reRequestMeeting(model);
//       });
//     }
//
//     return res;
//   }
//
//   static Future<BaseResultModel> reRequestMeeting(
//       MeetingRequestModel model) async {
//     var res = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: model.toJson(),
//         url: ApiURLs.request_video_meeting);
//
//     return res;
//   }
//
//   static Future<BaseResultModel> qrRequestJoinMeeting(
//     FCMNotificationModel fcm,
//   ) async {
//     var response = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: {"id": fcm.meetingId},
//         url: ApiURLs.qr_join_video_meeting);
//
//     if (response is ServerError)
//       Print.showSnackBar(message: response.message.toString());
//     else if (response is BaseError)
//       Print.showSnackBar(message: response.message);
//
//     return response;
//   }
//
//   static Future<BaseResultModel> qrJoinMeeting(
//     int meetingId,
//   ) async {
//     var response = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: {"id": meetingId},
//         url: ApiURLs.qr_join_video_meeting);
//     return response;
//   }
//
//   static Future<BaseResultModel> requestJoinMeeting(
//       ActionMeetingModel model) async {
//     var response = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: model.toJson(),
//         url: ApiURLs.join_video_meeting);
//
//     if (response is MeetingResponseModel) {
//     } else if (response is ServerError)
//       Print.showSnackBar(
//           message:
//               response.message.toString() + '\n' + response.details.toString(),
//           typeSnackBar: AnimatedSnackBarType.error);
//     else if (response is BaseError)
//       Print.showSnackBar(
//           message: response.message, typeSnackBar: AnimatedSnackBarType.error);
//
//     return response;
//   }
//
//   static Future<BaseResultModel> joinMeeting(
//     ActionMeetingModel model,
//   ) async {
//     var response = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: model.toJson(),
//         url: ApiURLs.join_video_meeting);
//     String name = AppSharedPreferences.name;
//     if (response is MeetingResponseModel) {
//       if (JWT.getUserRole() != UserRole.Interpreter)
//         await Future.delayed(Duration(seconds: 3));
//
//       await VideoMeetingService.startMeeting(
//           callerName: name,
//           roomText: model.roomText!,
//           serverUrl: response.link!,
//           meetingId: response.id!,
//           timeToLeave: (!response.isFree!) &&
//                   JWT.getUserRole() == UserRole.Client &&
//                   JWT.getMyId() == response.clientId
//               ? response.totalSeconds?.toInt()
//               : null,
//           callType: CallType.values[response.callType!]);
//     } else if (response is ServerError)
//       Print.showSnackBar(message: response.message.toString());
//     else if (response is BaseError)
//       Print.showSnackBar(message: response.message);
//
//     return response;
//   }
//
//   static Future<BaseResultModel> leaveMeeting(ActionMeetingModel model) async {
//     var res = await RemoteDataSource.request<MeetingResponseModel>(
//         converter: (json) => MeetingResponseModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: model.toJson(),
//         url: ApiURLs.leave_video_meeting);
//
//     return res;
//   }
//
//   static Future<BaseResultModel> cancelMeeting(ActionMeetingModel model) async {
//     var res = await RemoteDataSource.request<EmptyModel>(
//         converter: (json) => EmptyModel.fromJson(json),
//         method: HttpMethod.post,
//         withAuthentication: true,
//         data: model.toJson(),
//         url: ApiURLs.cancel_video_meeting);
//
//     return res;
//   }
// }
