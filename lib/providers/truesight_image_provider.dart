part of 'providers.dart';

@immutable
class TrueSightImageProvider extends DioImage {
  TrueSightImageProvider(
    Uri url, {
    String fallbackAssetPath = 'assets/images/fallback.png',
  }) : super(
          imageUrl: url,
          fallbackAssetPath: fallbackAssetPath,
        );
}
