
import 'dart:convert';

import '../../constants/constants.dart';
import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  static const keyAccessToken = "PREF_KEY_ACCESS_TOKEN";
  static const keyName = "PREF_KEY_NAME ";
  static const keyNumber = "PREF_KEY_NUMBER ";
  static const keyLang = "PREF_KEY_LANG";
  static const keyFirstTime = "PREF_KEY_FIRST_TIME";
  static const keyUserType = "PREF_KEY_USER_TYPE";
  static const keyLastCall = "PREF_KEY_LAST_CALL";
  static const keyWorkingStatus = "PREF_KEY_WORKING_STATUS";
  static const keyProduction = "PREF_KEY_Production";
  static const keyIsSliderMove = "PREF_KEY_isSliderMove";
  static const keyIsContactAppear = "PREF_KEY_isContactAppear";
  static const keyMrsMinuteAsPoint = "PREF_KEY_mrsMinuteAsPoint";
  static const keyVideoCallMinuteAsPoint = "PREF_KEY_videoCallMinuteAsPoint";
  static const keyCallsWaitingMinutes = "PREF_KEY_callsWaitingMinutes";
  static const keyMyPoints = "PREF_KEY_MyPoints";
  static const keyIsLoginWithUsername = "PREF_KeyIsLoginWithUsername";
  static const keyIsInCall = "PREF_KeyIsInCall";
  static const keyIsNewUser = "PREF_KeyIsNewUser";

  static bool? initialized;
  static SharedPreferencesProvider? _pref;

  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }

  static clear() {
    _pref!.clear();
  }

  static clearForLogOut() {
    removeAccessToken();
  }

  //AccessToken
  static String get accessToken => _pref!.read(keyAccessToken);

  static set accessToken(String accessToken) =>
      _pref!.save(keyAccessToken, accessToken);

  static bool get hasAccessToken => _pref?.contains(keyAccessToken) ?? false;

  static removeAccessToken() => _pref!.remove(keyAccessToken);

  //name
  static String get name => _pref!.read(keyName) ?? '';

  static set name(String n) => _pref!.save(keyName, n);

  //My Number
  static String get number => _pref?.read(keyNumber) ?? '';

  static set number(String number) => _pref?.save(keyNumber, number);

  //Production
  static bool get isProduction => _pref!.read(keyProduction) ?? true;

  static set isProduction(bool accessToken) =>
      _pref!.save(keyProduction, accessToken);

  // IsSliderMove
  static bool get isSliderMove => _pref!.read(keyIsSliderMove) ?? true;

  static set isSliderMove(bool isSliderMove) =>
      _pref!.save(keyIsSliderMove, isSliderMove);

  // isContactAppear
  static bool get isContactAppear => _pref!.read(keyIsContactAppear) ?? false;

  static set isContactAppear(bool isContactAppear) =>
      _pref!.save(keyIsContactAppear, isContactAppear);

  // mrsMinuteAsPoint
  static int get mrsMinuteAsPoint => _pref!.read(keyMrsMinuteAsPoint) ?? false;

  static set mrsMinuteAsPoint(int mrsMinuteAsPoint) =>
      _pref!.save(keyMrsMinuteAsPoint, mrsMinuteAsPoint);

  // videoCallMinuteAsPoint
  static int get videoCallMinuteAsPoint =>
      _pref!.read(keyVideoCallMinuteAsPoint) ?? 0;

  static set videoCallMinuteAsPoint(int videoCallMinuteAsPoint) =>
      _pref!.save(keyVideoCallMinuteAsPoint, videoCallMinuteAsPoint);

  // callsWaitingMinutes
  static int get callsWaitingMinutes =>
      _pref!.read(keyCallsWaitingMinutes) ?? 0;

  static set callsWaitingMinutes(int callsWaitingMinutes) =>
      _pref!.save(keyCallsWaitingMinutes, callsWaitingMinutes);

  // My Points
  static int get myPoints => _pref!.read(keyMyPoints) ?? 0;

  static set myPoints(int myPoints) => _pref!.save(keyMyPoints, myPoints);

  //Language
  static String get lang => _pref?.read(keyLang) ?? DEFAULT_LANGUAGE;

  static set lang(String lang) => _pref?.save(keyLang, lang);

  //In Call
  static bool get isInCall => _pref!.read(keyIsInCall) ?? false;

  static set isInCall(bool isInCall) {
    _pref!.save(keyIsInCall, isInCall);
  }

  //Is New User

  static set isNewUser(bool isNewUser) {
    _pref!.save(keyIsNewUser, isNewUser);
  }

  static bool get isNewUser => _pref!.read(keyIsNewUser) ?? false;

  //Last Call
  static Map<String, dynamic> get lastCall =>
      jsonDecode(_pref?.read(keyLastCall)) ?? {};

  static set lastCall(Map<String, dynamic> last) =>
      _pref?.save(keyLastCall, jsonEncode(last));

  //FirstTime
  static bool get firstTime {
    if (_pref?.readBoolean(keyFirstTime) == null) {
      firstTime = false;
      return true;
    }
    return false;
  }

  static set firstTime(bool first) => _pref!.saveBoolean(keyFirstTime, first);
}
