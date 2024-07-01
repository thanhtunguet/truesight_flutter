import 'package:truesight_flutter/truesight_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class _FileService {
  bool isOfficeFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.doc') ||
        filename.endsWith('.docx') ||
        filename.endsWith('.xls') ||
        filename.endsWith('.xlsx') ||
        filename.endsWith('.ppt') ||
        filename.endsWith('.pptx');
  }

  bool isDocFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.doc') || filename.endsWith('.docx');
  }

  bool isSpreadSheetFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.xls') || filename.endsWith('.xlsx');
  }

  bool isPresentationFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.ppt') || filename.endsWith('.pptx');
  }

  bool isImageFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.jpg') ||
        filename.endsWith('.jpeg') ||
        filename.endsWith('.png');
  }

  bool isPDFFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.pdf');
  }

  bool isInlineFile(File file) {
    final filename = file.name.value.toLowerCase();
    return filename.endsWith('.txt') || filename.endsWith('.json');
  }

  Future<String> buildUrlWithToken(File file) async {
    var fileUrl = '${truesightService.baseApiUrl}${file.url.value}';
    final cookies = await truesightService.persistCookieJar
        .loadForRequest(Uri.parse(fileUrl));
    final token = cookies.where((cookie) => cookie.name == 'Token').first;
    fileUrl = '$fileUrl&token=${token.value}&filename=${file.name.value}';
    return fileUrl;
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}

final fileService = _FileService();
