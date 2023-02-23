import 'package:url_launcher/url_launcher_string.dart';

class EasyLaunch {
  static Future<void> launch(String? url,
      {String fallbackUrl = '',
      required launchType,
      LaunchMode mode = LaunchMode.platformDefault}) async {
    if(url == null) {
      return ;
    }
    String temp = '';
    switch (launchType) {
      case LaunchType.mail:
        temp = 'mailto:';
        break;
      case LaunchType.phone:
        temp = 'tel://';
        break;
    }
    url = temp + url;
    try {
      await canLaunchUrlString(url)
          ? await launchUrlString(url, mode: mode)
          : await canLaunchUrlString(fallbackUrl);
    } catch (ignored) {
      //ignored
    }
  }
}

enum LaunchType {
  mail,
  phone,
  browser,
}
