import 'package:dio/dio.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

final class IpRepository extends HttpRepository {
  @override
  InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper();

  @override
  String? get baseUrl => 'https://checkip.amazonaws.com';

  Future<String> getIp() async {
    return get('/').then((response) => response.bodyAsString());
  }
}
