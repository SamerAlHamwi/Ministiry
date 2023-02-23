import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';
class GPS{
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static String distanceBetween({lat1, lon1, lat2, lon2}){
    double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2)  ;
    if(distanceInMeters < 100)
      return distanceInMeters. toStringAsFixed(1) +  ' '+  'Meters'.tr();
    else
      return (distanceInMeters / 1000).toStringAsFixed(1) + ' '+  'Km'.tr();

  }
}
