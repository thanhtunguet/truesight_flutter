part of 'providers.dart';

@immutable
class TrueSightImageProvider extends DioImage {
  TrueSightImageProvider(Uri url) : super(url) {
    DioImage.defaultDio.interceptors.add(truesightService.cookieManager);
  }
}
