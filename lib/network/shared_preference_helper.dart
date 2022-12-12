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

  Future<Map<String, String>> getUserDetails() async {
    return await storage.readAll();
  }

  deleteAll() {
    storage.deleteAll();
  }
}
