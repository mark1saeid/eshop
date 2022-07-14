import 'package:geolocation/geolocation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  // Allows request any permission in the Permission Group with this method
  static Future<bool> requestPermission(Permission permission) async {
    final PermissionUtil _permissionHandler = PermissionUtil();
  //  _permissionHandler.shouldShowRequestPermissionRationale(permission);
    final result = await permission.request();
    if (permission.status == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  // Allows checks on any permission in the Permission Group with this method
  static Future<bool> hasPermission(Permission permission) async {
   // final PermissionUtil _permissionHandler = PermissionUtil();
    var permissionStatus =
        await permission.status;
    return permissionStatus == PermissionStatus.granted;
  }

  //below is about gps and location services checks

  static Future<bool> isGpsServiceActive() async {
    final GeolocationResult gps = await Geolocation.isLocationOperational();
    if (!gps.isSuccessful) {
      await Geolocation.enableLocationServices()
          .then((GeolocationResult onValue) async {
        if (onValue.isSuccessful)
          return true;
        else
          return false;
      });
    }
    return true;
  }

  static Future<bool> isLocationServiceAndPermissionsActive() async {
    final GeolocationResult gpsServiceActive =
        await Geolocation.isLocationOperational();
    final gpsPermissionGranted =
        await PermissionUtil.hasPermission(Permission.locationWhenInUse);

    if (gpsServiceActive.isSuccessful == false || gpsPermissionGranted == false)
      return false;

    return true;
  }
}
