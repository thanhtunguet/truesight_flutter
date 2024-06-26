import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:truesight_flutter/providers/dio_image_provider.dart';

final box = Hive.box('truesight_app_service');

class TruesightAppService {
  TruesightAppService._();

  late PersistCookieJar persistCookieJar;

  Future<void> initialize({
    bool enableDotenv = true,
    bool enableHive = true,
  }) async {
    if (enableDotenv) {
      await dotenv.load();
    }
    if (enableHive) {
      await Hive.initFlutter();
      await Hive.openBox('truesight_app_service');
    }

    Directory documentsDir = await getApplicationDocumentsDirectory();
    final documentsPath = documentsDir.path;
    persistCookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(documentsPath),
      persistSession: true,
    );

    DioImage.defaultDio.interceptors.add(
      CookieManager(truesightService.persistCookieJar),
    );
  }

  bool get faceIdEnabled {
    return _getOrCreate('faceId', defaultValue: true);
  }

  set faceIdEnabled(bool value) {
    box.put('faceId', value);
  }

  String get baseApiUrl {
    return _getOrCreate('baseApiUrl', defaultValue: null) ?? dotenv.env['BASE_API_URL']!;
  }

  set baseApiUrl(String value) {
    box.put('baseApiUrl', value);
  }

  dynamic _getOrCreate(
    String key, {
    dynamic defaultValue,
  }) {
    var result = box.get(key);
    if (result == null) {
      box.put(key, defaultValue);
      result = defaultValue;
    }
    return result;
  }
}

final truesightService = TruesightAppService._();
