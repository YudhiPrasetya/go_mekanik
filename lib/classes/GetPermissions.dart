import 'package:go_mekanik/util/ShowToast.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissions {
  ShowToast showToast = ShowToast();

  Future<bool> getCameraPermission() async {
    PermissionStatus permissionStatus = await Permission.camera.status;
    if (permissionStatus.isGranted) {
      return true;
    } else if (permissionStatus.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        return true;
      } else {
        showToast.showToastWarning('Diperlukan izin penggunaan kamera');
        return false;
      }
    }
    return false;
  }

  Future<bool> getStoragePermission() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      return true;
    } else if (permissionStatus.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        showToast
            .showToastWarning('Diperlukan izin penggunaan tempat penyimpanan');
        return false;
      }
    }
    return false;
  }
}
