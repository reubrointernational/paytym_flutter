import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SharedPreferenceHelper extends GetxController {
  final storage = const FlutterSecureStorage();

  addUserLoginCredentials(String email, String password) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'key', value: password);
  }

  Future<Map<String, String>> getUserLoginCredentials() async {
    return await storage.readAll();
  }

  deleteAll() {
    storage.deleteAll();
  }
}
