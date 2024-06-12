part of 'providers.dart';

@immutable
class TrueSightImageProvider extends ImageProvider<Uri> {
  const TrueSightImageProvider(this.url);

  final String url;

  @override
  Future<Uri> obtainKey(ImageConfiguration configuration) async {
    final cookies = await getCookies();
    final uri = Uri.parse(url);
    final Uri result = uri.replace(
      queryParameters: <String, String>{
        'token': cookies.token ?? '',
      },
    );
    return SynchronousFuture<Uri>(result);
  }

  static HttpClient get _httpClient {
    HttpClient? client;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) {
        client = debugNetworkImageHttpClientProvider!();
      }
      return true;
    }());
    return client ?? HttpClient()
      ..autoUncompress = false;
  }

  @override
  ImageStreamCompleter loadImage(Uri key, ImageDecoderCallback decode) {
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();
    debugPrint('Fetching "$key"...');
    return MultiFrameImageStreamCompleter(
      codec: _httpClient
          .getUrl(key)
          .then<HttpClientResponse>((HttpClientRequest request) => request.close())
          .then<Uint8List>((HttpClientResponse response) {
            return consolidateHttpClientResponseBytes(
              response,
              onBytesReceived: (int cumulative, int? total) {
                chunkEvents.add(ImageChunkEvent(
                  cumulativeBytesLoaded: cumulative,
                  expectedTotalBytes: total,
                ));
              },
            );
          })
          .catchError((Object e, StackTrace stack) {
            scheduleMicrotask(() {
              PaintingBinding.instance.imageCache.evict(key);
            });
            return Future<Uint8List>.error(e, stack);
          })
          .whenComplete(chunkEvents.close)
          .then<ui.ImmutableBuffer>(ui.ImmutableBuffer.fromUint8List)
          .then<ui.Codec>(decode),
      chunkEvents: chunkEvents.stream,
      scale: 1.0,
      debugLabel: '"key"',
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<Uri>('URL', key),
      ],
    );
  }

  @override
  String toString() => '${objectRuntimeType(this, 'TrueSightImageProvider')}("$url")';
}
