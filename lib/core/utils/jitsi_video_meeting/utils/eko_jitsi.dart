// import 'dart:io';
//
// import 'package:eko_jitsi/eko_jitsi.dart';
// import 'package:eko_jitsi/eko_jitsi_listener.dart';
// import 'package:eko_jitsi/feature_flag/feature_flag_enum.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// // import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// // import 'package:jitsi_meet/jitsi_meet.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wakelock/wakelock.dart';
//
//
// import 'package:quiver/async.dart';
//
// class EkoJitsiMeet {
//   final String roomText;
//   final String serverUrl;
//   final String subjectText;
//   final String nameText;
//   final Function() onLeave;
//   int tryNo = 0;
//
//   EkoJitsiMeet(
//       {required this.onLeave,
//         required this.roomText,
//         required this.serverUrl,
//         required this.subjectText,
//         required this.nameText});
//
//   joinMeeting() {
//     _call();
//   }
//
//   leaveMeeting() {
//     EkoJitsi.closeMeeting();
//     EkoJitsi.closeMeeting();
//     EkoJitsi.removeAllListeners();
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
//         FeatureFlagEnum.RECORDING_ENABLED: true,
//         FeatureFlagEnum.MEETING_NAME_ENABLED: true,
//         FeatureFlagEnum.RAISE_HAND_ENABLED: false,
//       };
//
//
//
//       // FeatureFlag featureFlag = FeatureFlag();
//       // featureFlag.resolution = FeatureFlagVideoResolution.LD_RESOLUTION;
//       if (!kIsWeb) {
//         // Here is an example, disabling features for each platform
//         if (Platform.isAndroid) {
//           // Disable ConnectionService usage on Android to avoid issues (see README)
//           featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//         } else if (Platform.isIOS) {
//           // Disable PIP on iOS as it looks weird
//           featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
//         }
//       }
//
//       // Define meetings options here
//       var options = JitsiMeetingOptions()
//         ..room = roomText
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
//       await EkoJitsi.joinMeeting(
//         options,
//
//         listener: EkoJitsiListener(
//
//           onConferenceWillJoin: _onConferenceWillJoin,
//           onConferenceJoined: _onConferenceJoined,
//           onPictureInPictureTerminated: ({message}) {
//             print("onPictureInPictureTerminated ${message}");
//           },
//           onPictureInPictureWillEnter: ({message}) {
//             print("onPictureInPictureWillEnter ${message}");
//           },
//           onError: (error) {
//             print("error_error_error_error");
//             _onConferenceTerminated(message: error);
//           },
//           onConferenceTerminated: _onConferenceTerminated,
//         ),
//       );
//     } catch (error) {
//       debugPrint("error: $error");
//     }
//   }
//
//   void _onConferenceWillJoin({message}) async {
//     try {
//       Wakelock.toggle(enable: true);
//     } catch (e) {
//       print("error Wakelock");
//     }
//     debugPrint("_onConferenceWillJoin broadcasted with message: $message");
//   }
//
//   void _onConferenceJoined({message}) {
//     debugPrint("_onConferenceJoined broadcasted with message: $message");
//   }
//
//   void _onConferenceTerminated({message}) async {
//     print("_onConferenceTerminated");
//     onLeave();
//   }
// }