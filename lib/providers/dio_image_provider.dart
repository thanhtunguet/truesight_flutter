import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DioImage extends ImageProvider<DioImage> {
  static final defaultDio = Dio();

  final Uri imageUrl;
  final String fallbackAssetPath;

  DioImage({
    required this.imageUrl,
    this.fallbackAssetPath = '../assets/image_placeholder.png',
  });

  @override
  Future<DioImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<DioImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(DioImage key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(_loadAsync(key, decode));
  }

  Future<ImageInfo> _loadAsync(
      DioImage key, ImageDecoderCallback decode) async {
    try {
      Response response = await defaultDio.get<List<int>>(
        imageUrl.toString(),
        options: Options(responseType: ResponseType.bytes),
      );
      final Uint8List bytes = Uint8List.fromList(response.data!);

      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);

      // Decode the image bytes
      final ui.Codec codec = await decode(buffer);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      return ImageInfo(image: frameInfo.image);
    } catch (e) {
      // If network image fails, load the fallback asset image
      final ByteData assetData = await rootBundle.load(fallbackAssetPath);
      final Uint8List bytes = assetData.buffer.asUint8List();
      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      // Decode the asset image bytes
      final ui.Codec codec = await decode(buffer);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      return ImageInfo(image: frameInfo.image);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final DioImage typedOther = other as DioImage;
    return imageUrl == typedOther.imageUrl &&
        fallbackAssetPath == typedOther.fallbackAssetPath;
  }

  @override
  int get hashCode => Object.hash(imageUrl, fallbackAssetPath);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'CustomNetworkImageProvider')}(url: $imageUrl, fallback: $fallbackAssetPath)';
}
