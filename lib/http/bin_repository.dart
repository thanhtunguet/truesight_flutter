part of 'http.dart';

class BinRepository extends HttpRepository {
  BinRepository(this.baseUrl);

  @override
  String? baseUrl;

  @override
  bool get useInterceptors => true;

  @override
  InterceptorsWrapper interceptorsWrapper = globalInterceptorsWrapper;

  Future<File> downloadFile(
    String url, {
    required String savePath,
    required String filename,
  }) async {
    final directory = Directory(savePath);
    final filePath = join(directory.path, filename);

    await download(url, filePath).then(
      (response) => response.data,
    );
    return File(filePath);
  }

  Future<Uint8List> downloadBytes(String url) {
    return get(
      url,
      options: Options(
        responseType: ResponseType.bytes, // Ensures the response is treated as a byte stream
      ),
    ).then(
      (response) => response.data,
    );
  }
}
