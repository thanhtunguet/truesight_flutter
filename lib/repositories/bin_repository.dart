part of 'repositories.dart';

abstract class BinRepository extends HttpRepository {
  BinRepository(this.baseUrl);

  @override
  String? baseUrl;

  Future<io.File> downloadFile(
    String url, {
    required String savePath,
    required String filename,
  }) async {
    final directory = io.Directory(savePath);
    final filePath = path.join(directory.path, filename);

    await download(url, filePath).then(
      (response) => response.data,
    );
    return io.File(filePath);
  }

  Future<Uint8List> downloadBytes(String url) {
    return get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    ).then(
      (response) => response.data,
    );
  }
}
