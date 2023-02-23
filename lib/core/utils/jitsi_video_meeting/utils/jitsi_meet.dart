// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
//
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wakelock/wakelock.dart';
//
// import '../../jwt/jwt.dart';
//
// class Jitsi {
//   final String roomText;
//   final String serverUrl;
//   final String subjectText;
//   final String nameText;
//   final Function() onLeave;
//   int tryNo = 0;
//
//   Jitsi(
//       {required this.onLeave,
//       required this.roomText,
//       required this.serverUrl,
//       required this.subjectText,
//       required this.nameText});
//
//   joinMeeting() {
//     _call();
//   }
//
//   leaveMeeting() {
//     JitsiMeet.closeMeeting();
//
//     JitsiMeet.removeAllListeners();
//   }
//
//   _call() async {
//     try {
//       Map<FeatureFlagEnum, bool> featureFlags = {
//         FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
//         FeatureFlagEnum.ADD_PEOPLE_ENABLED: true,
//         FeatureFlagEnum.CHAT_ENABLED: true,
//         FeatureFlagEnum.INVITE_ENABLED: true,
//         FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
//         FeatureFlagEnum.TILE_VIEW_ENABLED: false,
//         FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: true,
//         FeatureFlagEnum.CALENDAR_ENABLED: true,
//         FeatureFlagEnum.LIVE_STREAMING_ENABLED: true,
//         FeatureFlagEnum.RECORDING_ENABLED:
//             JWT.getUserRole() == UserRole.Interpreter,
//         FeatureFlagEnum.IOS_RECORDING_ENABLED:
//             JWT.getUserRole() == UserRole.Interpreter,
//         FeatureFlagEnum.MEETING_NAME_ENABLED: true,
//         FeatureFlagEnum.RAISE_HAND_ENABLED: false,
//         FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
//       };
//
//       FeatureFlag featureFlag = FeatureFlag();
//       featureFlag.resolution = FeatureFlagVideoResolution.LD_RESOLUTION;
//       if (!kIsWeb) {
//         // Here is an example, disabling features for each platform
//         if (Platform.isAndroid) {
//           featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//           // Disable ConnectionService usage on Android to avoid issues (see README)
//           //   featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//         } else if (Platform.isIOS) {
//           // Disable PIP on iOS as it looks weird
//           // featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
//         }
//       }
//
//       // Define meetings options here
//       var options = JitsiMeetingOptions(room: roomText)
//         ..serverURL = serverUrl
//         ..subject = subjectText
//         ..userDisplayName = nameText
//         ..userAvatarURL = ""
//         ..audioOnly = false
//         ..audioMuted = false
//         ..videoMuted = false
//         ..featureFlags.addAll(featureFlags);
//
//       debugPrint("JitsiMeetingOptions: $options");
//       await JitsiMeet.joinMeeting(
//         options,
//         listener: JitsiMeetingListener(
//           onConferenceWillJoin: _onConferenceWillJoin,
//           onConferenceJoined: _onConferenceJoined,
//           onPictureInPictureTerminated: (message) {
//             print("onPictureInPictureTerminated ${message}");
//           },
//           onPictureInPictureWillEnter: (message) {
//             print("onPictureInPictureWillEnter ${message}");
//           },
//           onError: (error) {
//             print("error_error_error_error");
//             _onConferenceTerminated(error);
//           },
//           onConferenceTerminated: _onConferenceTerminated,
//         ),
//       );
//     } catch (error) {
//       debugPrint("error: $error");
//     }
//   }
//
//   void _onConferenceWillJoin(message) async {
//     try {
//       Wakelock.toggle(enable: true);
//     } catch (e) {
//       print("error Wakelock");
//     }
//     debugPrint("_onConferenceWillJoin broadcasted with message: $message");
//   }
//
//   void _onConferenceJoined(message) {
//     debugPrint("_onConferenceJoined broadcasted with message: $message");
//   }
//
//   void _onConferenceTerminated(message) async {
//     print("_onConferenceTerminated");
//     onLeave();
//
//     // Timer timerTerminated;
//     // int clock = 0, goal = 4, tryNumber = 5;
//     //
//     // if (message != null) {
//     //   if (message.containsKey('error')) {
//     //     while (true) {
//     //       timerTerminated = Timer.periodic(Duration(seconds: goal), (Timer t) {
//     //         if (message.containsKey('error') == false) {
//     //           clock++;
//     //           if (clock >= 3) {
//     //             onLeave();
//     //             // timerTerminated.cancel();
//     //           } else {
//     //             dialogError();
//     //           }
//     //         } else {
//     //           // timerTerminated?.cancel();
//     //           clock = 0;
//     //           dialogError();
//     //         }
//     //       });
//     //     }
//     //   } else {
//     //     String meeting = JitsiVideoMeeting.meetingId!;
//     //     onLeave();
//     //     // if (isDoctorAgent) {
//     //     //   final result = await MeetingRepo().checkDoctorJoined(
//     //     //       JitsiVideoMeeting.meetingId);
//     //     //   if (result.hasDataOnly) {
//     //     //     if (result.data.status)
//     //     //       showDialog(
//     //     //           barrierDismissible: false,
//     //     //           context: gNavigationService.navigationKey.currentContext,
//     //     //           builder: (context) {
//     //     //             print("JitsiVideoMeeting.meetingId" + meeting.toString());
//     //     //             return AddSummary(meetingId: meeting);
//     //     //           });
//     //     //   }
//     //     // }
//     //     // timerTerminated?.cancel();
//     //   }
//     //   message.forEach((key, value) {
//     //     print(key.toString() + "MustafaKurdiMustafa" + value.toString() + "\n");
//     //   });
//     // }
//   }
//
//   _onError(error) {
//     print('JitsiMeet _onError');
//     error.forEach((key, value) {
//       print(key.toString() + " " + value.toString() + "\n");
//     });
//     debugPrint("_onError : $error");
//   }
//
//   void _callOnBrowser() async => await canLaunch(serverUrl)
//       ? await launch(serverUrl + '/' + roomText)
//       : throw 'Could not launch $serverUrl';
//
//   dialogError() {
//     //   tryNo++;
//     //   if (tryNo <= 6) {
//     //     // this._call();
//     //     showDialog(
//     //         barrierDismissible: false,
//     //         context: gNavigationService.navigationKey.currentContext,
//     //         builder: (context) {
//     //           return AlertDialog(
//     //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
//     //             title: Text(translate('an_error_occurred_please_try_again') + '  ' + tryNo.toString()),
//     //             actions: <Widget>[
//     //               FlatButton(
//     //                 onPressed: () {
//     //                   onLeave();
//     //                   gNavigationService.goRoot();
//     //                 },
//     //                 child: Text(
//     //                   translate("no"),
//     //                 ),
//     //               ),
//     //               FlatButton(
//     //                 onPressed: () {
//     //                   gNavigationService.pop();
//     //                   this.leaveMeeting();
//     //                   this._call(isPatient);
//     //                 },
//     //                 child: Text(
//     //                   translate("ry_again"),
//     //                 ),
//     //               ),
//     //             ],
//     //           );
//     //         });
//     //   } else {
//     //     onLeave();
//     //     gNavigationService.goRoot();
//     //   }
//     // }
//   }
// }
