import 'package:flutter/foundation.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:wakelock/wakelock.dart';

class Jitsi {
  final String roomText;
  final String serverUrl;
  final String subjectText;
  final String nameText;
  final void Function() onLeave;
  int tryNo = 0;

  Jitsi(
      {void Function()? onLeave,
      required this.roomText,
      required this.serverUrl,
      required this.subjectText,
      required this.nameText})
      : onLeave = onLeave ?? Jitsi.defaultOnLeave;

  static void defaultOnLeave() {}

  joinMeeting() {
    _call();
  }

  leaveMeeting() {
    JitsiMeetWrapper.hangUp();
  }

  _call() async {
    Map<FeatureFlag, bool> featureFlags = {
      //FeatureFlag.isPrejoinPageEnabled: false,
      FeatureFlag.isNotificationsEnabled: false,
      // FeatureFlag.isWelcomePageEnabled: false,
      FeatureFlag.isInviteEnabled: true,
      FeatureFlag.isChatEnabled: true,
      FeatureFlag.isMeetingPasswordEnabled: false,
      FeatureFlag.isTileViewEnabled: false,
      FeatureFlag.isToolboxAlwaysVisible: true,
      FeatureFlag.isCalendarEnabled: true,
      FeatureFlag.isLiveStreamingEnabled: true,
      FeatureFlag.isRecordingEnabled: true,
      FeatureFlag.isIosRecordingEnabled: true,
      FeatureFlag.isMeetingNameEnabled: true,
      FeatureFlag.isRaiseHandEnabled: false,
      FeatureFlag.isCallIntegrationEnabled: true,
      FeatureFlag.isAndroidScreensharingEnabled: true,
      FeatureFlag.isVideoShareButtonEnabled: true,
      FeatureFlag.isVideoMuteButtonEnabled: true,
    };
    var options = JitsiMeetingOptions(
        roomNameOrUrl: roomText,
        isAudioMuted: false,
        isAudioOnly: false,
        isVideoMuted: false,
        userDisplayName: nameText,
        serverUrl: serverUrl,
        featureFlags: featureFlags);

    JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(
          onConferenceJoined: _onConferenceJoined,
          onClosed: _onClosed,
          onConferenceWillJoin: _onConferenceWillJoin,
          onConferenceTerminated: _onConferenceTerminated,
        ));
  }

  void _onClosed() async {
    debugPrint("onClosed");
    onLeave();
  }

  void _onConferenceWillJoin(message) async {
    try {
      Wakelock.toggle(enable: true);
    } catch (e) {
      if (kDebugMode) {
        print("error Wakelock");
      }
    }
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message, error) async {
    if (kDebugMode) {
      print("_onConferenceTerminated");
    }
    onLeave();
  }
}
