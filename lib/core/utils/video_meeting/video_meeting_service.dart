
import '../../../features/agora/presentation/agora_call_screen.dart';
import '../../../features/home_app/data/calls_list_response.dart';
import '../../notification/data/fcm_notification_model.dart';
import '../Navigation/Navigation.dart';
import '../shared_preferences/SharedPreferencesHelper.dart';

class VideoMeetingService {

  static startMeeting(
      {required Call call}) async {

    AppSharedPreferences.isInCall = true;
    Navigation.push(VideoCallScreen(model: call));
  }


  static leaveMeeting(FCMNotificationModel fcm) async {
    try {
      AppSharedPreferences.isInCall = false;
    } on Exception {}
  }
}
