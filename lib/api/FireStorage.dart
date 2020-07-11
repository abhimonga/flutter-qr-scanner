import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FireStorage {
  static Future<String> getFilePath() async {
    String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
    final Directory extdDirectory = await getApplicationDocumentsDirectory();
    final String dirPath = '${extdDirectory.path}/pictures/payment';
    await Directory(dirPath).create(recursive: true);
    return '$dirPath/${timestamp()}.png';
  }

  static Future<File> writeQrImage(File file, ByteData byteData) async {
    final buffer = byteData.buffer;
    return await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}
