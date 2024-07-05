import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:truesight_flutter/extensions/cookie_jar.dart';
import 'package:truesight_flutter/providers/dio_image_provider.dart';

class TruesightAppService {
  static TruesightAppService instance = truesightService;

  static const _boxName = 'truesight_app_service';

  Box get _box => Hive.box(_boxName);

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
      await Hive.openBox(_boxName);
    }

    persistCookieJar = await TrueSightCookieJar.init();

    DioImage.defaultDio.interceptors.add(
      CookieManager(truesightService.persistCookieJar),
    );
  }

  bool get faceIdEnabled {
    return _getOrCreate('faceId', defaultValue: true);
  }

  set faceIdEnabled(bool value) {
    _box.put('faceId', value);
  }

  String get baseApiUrl {
    return _getOrCreate(
      'baseApiUrl',
      defaultValue: dotenv.env['BASE_API_URL']!,
    );
  }

  set baseApiUrl(String value) {
    _box.put('baseApiUrl', value);
  }

  int get tenantId {
    return _getOrCreate('tenantId', defaultValue: 0);
  }

  set tenantId(int tenantId) {
    _box.put('tenantId', tenantId);
  }

  void removeTenantId() {
    _box.delete('tenantId');
  }

  dynamic _getOrCreate(
    String key, {
    dynamic defaultValue,
  }) {
    var result = _box.get(key);
    if (result == null) {
      _box.put(key, defaultValue);
      result = defaultValue;
    }
    return result;
  }
}

final truesightService = TruesightAppService._();
