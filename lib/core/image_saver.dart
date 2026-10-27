import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

/// Downloads a remote image into a user-visible directory.
class ImageSaver {
  ImageSaver._();

  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 30),
    responseType: ResponseType.bytes,
  ));

  /// Saves [url] and returns the local file.
  static Future<File> save(String url) async {
    final Directory dir;
    if (Platform.isAndroid) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = (await getDownloadsDirectory()) ?? await getApplicationDocumentsDirectory();
    }

    final rawName = url.split('/').last.split('?').first;
    final name = rawName.isEmpty ? 'image.jpg' : rawName;
    final file = File(
      '${dir.path}${Platform.pathSeparator}feiba_${DateTime.now().millisecondsSinceEpoch}_$name',
    );

    final response = await _dio.get<List<int>>(url);
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) {
      throw StateError('empty image payload');
    }
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
