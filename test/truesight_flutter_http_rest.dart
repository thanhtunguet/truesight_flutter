import 'package:dio/src/dio_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/http/http.dart';

final class IpRepository extends HttpRepository {
  @override
  InterceptorsWrapper interceptorWrapper = InterceptorsWrapper();

  @override
  String? get baseUrl => 'https://checkip.amazonaws.com';

  Future<String> getIp() async {
    return get('/').then((response) => response.bodyAsString());
  }
}

void main() {
  test('http repository', () async {
    final ipRepository = IpRepository();
    final ipAddr = await ipRepository.getIp();
    if (kDebugMode) {
      print(ipAddr);
    }
  });
}
