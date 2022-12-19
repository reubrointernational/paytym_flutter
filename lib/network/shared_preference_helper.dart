import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/login/login_response_model.dart';

class SharedPreferenceHelper extends GetxController {
  final storage = const FlutterSecureStorage();

  addUserDetails(LoginResponseModel? loginResponseModel) async {
    if (loginResponseModel != null) {
      await storage.write(
          key: 'loginDetails',
          value: loginResponseModelToJson(loginResponseModel));
    }
  }

  addCheckInDetails([bool? isQrCheckIn]) async {
    isQrCheckIn == null
        ? await storage.write(key: 'checkIn', value: DateTime.now().toString())
        : await storage.write(
            key: 'checkInQr', value: DateTime.now().toString());
  }

  Future<Map<String, String>> getStorageData() async {
    return await storage.readAll();
  }

  deleteAll() {
    storage.deleteAll();
  }

  deleteAllCheckInData() {
    storage.delete(key: 'checkIn');
    storage.delete(key: 'checkInQr');
  }
}
