import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';
import '../../../constants/Keys.dart';
import '../../../constants/constants.dart';


import '../../../notification/data/fcm_notification_model.dart';
import '../../shared_preferences/SharedPreferencesHelper.dart';
import '../data/action_meeting_model.dart';

class Callkit {
  static ActionMeetingModel activeCall = ActionMeetingModel();
  static FCMNotificationModel fcm = FCMNotificationModel();

  static showCall(FCMNotificationModel fcm) async {
    try {
      FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
        await AppSharedPreferences.init();
        Timer.periodic(
          const Duration(milliseconds: 5000),
          (timer) {
            if (Keys.navigatorKey.currentState != null) timer.cancel();
          },
        );
        if (Keys.navigatorKey.currentContext == null) {
          Timer.periodic(
            const Duration(milliseconds: 5000),
            (timer) {
              if (Keys.navigatorKey.currentState != null) timer.cancel();
            },
          );
        }

        switch (event!.event) {
          case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_INCOMING:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_START:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_ACCEPT:
            await FlutterCallkitIncoming.endAllCalls();
            break;
          case Event.ACTION_CALL_DECLINE:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_ENDED:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_TIMEOUT:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_CALLBACK:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_TOGGLE_HOLD:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_TOGGLE_MUTE:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_TOGGLE_DMTF:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_TOGGLE_GROUP:
            // TODO: Handle this case.
            break;
          case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
            // TODO: Handle this case.
            break;
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    String id = const Uuid().v4();

    var params = CallKitParams(
      id: id,
      nameCaller: 'Caller name',
      appName: 'MetaSign',
      type: 2,
      duration: 31000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      textMissedCall: 'Missed call',
      textCallback: '',
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: false,
        isShowLogo: true,
        isShowCallback: false,
        isShowMissedCallNotification: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0088cc',
        //   backgroundUrl: 'assets/test.png',
        //   actionColor: '#4CAF50',
      ),
      // ios: IOSParams(
      //   iconName: 'CallKitLogo',
      //   handleType: '',
      //   supportsVideo: true,
      //   maximumCallGroups: 2,
      //   maximumCallsPerCallGroup: 1,
      //   audioSessionMode: 'default',
      //   audioSessionActive: true,
      //   audioSessionPreferredSampleRate: 44100.0,
      //   audioSessionPreferredIOBufferDuration: 0.005,
      //   supportsDTMF: true,
      //   supportsHolding: true,
      //   supportsGrouping: false,
      //   supportsUngrouping: false,
      //   ringtonePath: 'system_ringtone_default',
      // ),
    );

//

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  static endCall(FCMNotificationModel fcm) {
    FlutterCallkitIncoming.endCall('');
  }
}
