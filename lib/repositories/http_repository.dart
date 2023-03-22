import 'dart:io';

import 'package:dio/dio.dart';

import './repository.dart';

abstract class HttpRepository extends Repository {
  Dio dio = Dio();

  String get baseUrl {
    return dio.options.baseUrl;
  }

  set baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = ContentType.json.mimeType;
  }

  Future<Response> post(
    String url, {
    dynamic data,
  }) {
    return dio.post(url, data: data);
  }

  Future<Response> get(
    String url, {
    dynamic queryParameters,
  }) {
    return dio.get(url, queryParameters: queryParameters);
  }
}
