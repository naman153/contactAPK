import 'package:permission_handler/permission_handler.dart';

class PermissionController {
  checkPermissionStatus() async {
    if (await Permission.microphone.isDenied)
      requestPermission(false, Permission.contacts);
    if (await Permission.microphone.isPermanentlyDenied)
      requestPermission(true, Permission.contacts);
  }

  requestAllPermissions() async {
    int count = -1;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.contacts
    ].request().onError((error, stackTrace) {
      print("ERROROROOROROROROR");
      return {};
    });
    await Future.forEach(statuses.values, (element) async {
      if (await element.isGranted == true) count++;
    });
    print(count);
    return (count >= 0) ? true : false;
  }

  Future<bool> requestPermission(bool openSetting,
      Permission? typePermission) async {
    bool isGranted = false;
    if (openSetting) {
      isGranted = await openAppSettings();
    } else {
      if (await typePermission!.request().isGranted) {
        isGranted = true;
      }
    }
    return isGranted;
  }

}

PermissionController permissionController = PermissionController();