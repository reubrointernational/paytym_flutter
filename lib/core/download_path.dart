import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DownloadPath {
  Future<String> getDownloadPath() async {
    Directory directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
        }
      }
    } catch (err) {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory.path;
  }
}
