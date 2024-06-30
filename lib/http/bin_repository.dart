part of 'http.dart';

class BinRepository extends HttpRepository {
  BinRepository(this.baseUrl);

  @override
  String? baseUrl;

  @override
  bool get useInterceptors => true;

  Future<io.File> downloadFile(
    String url, {
    required String savePath,
    required String filename,
  }) async {
    final directory = io.Directory(savePath);
    final filePath = join(directory.path, filename);

    await download(url, filePath).then(
      (response) => response.data,
    );
    return io.File(filePath);
  }

  Future<Uint8List> downloadBytes(String url) {
    return get(
      url,
      options: Options(
        responseType: ResponseType
            .bytes, // Ensures the response is treated as a byte stream
      ),
    ).then(
      (response) => response.data,
    );
  }
}
