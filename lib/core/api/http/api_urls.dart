import '../../constants/app_settings.dart';

class ApiURLs {
  ///baseUrl
  static const String baseUrl = AppSettings.baseUrl;
  static const String servicesUrl = '${baseUrl}services/';
  static const String appUrl = '${servicesUrl}app/';
  static const String authUrl = '${baseUrl}TokenAuth/';
  static const String notitfyScreenUrl =
      '${baseUrl}services/app/Call/NotifyScreenToJoin';
  static const String CancleCallRequestUrl =
      '${baseUrl}services/app/Call/CancleRequest';

  ///USER
  static const String userUrl = '${appUrl}User/';
  static const String setFCMToken = '${userUrl}setCurrentFcmToken/';
  static const String loginUrl = '${authUrl}Authenticate';
  static const String changeLanguageUrl = '${userUrl}changeLanguage';

  ///Calls
  static const String callUrl = '${appUrl}Call/';
  static const String getAllCalls = '${callUrl}GetAll';
  static const String joinCall = '${callUrl}JoinCall';
  static const String leaveCall = '${callUrl}LeaveCall';

  static const String updateUrl = '${baseUrl}services/app/AppVersions/GetLatest';

}
