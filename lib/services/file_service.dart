import 'package:flutter/material.dart';
import 'package:supa_carbon_icons/supa_carbon_icons.dart';
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

  String createOfficeViewerUrl(String fileUrl) {
    fileUrl = Uri.encodeComponent(fileUrl);
    return 'https://view.officeapps.live.com/op/view.aspx?src=$fileUrl';
  }

  String createGoogleDocsViewerUrl(String fileUrl) {
    fileUrl = Uri.encodeComponent(fileUrl);
    return 'https://docs.google.com/gview?embedded=true&url=$fileUrl';
  }

  IconData iconData(File file) {
    final filename = file.name.value.toLowerCase();
    if (filename.endsWith('.pdf')) {
      return CarbonIcons.pdf;
    }
    if (filename.endsWith('doc') || filename.endsWith('docx')) {
      return CarbonIcons.doc;
    }
    if (filename.endsWith('ppt') || filename.endsWith('pptx')) {
      return CarbonIcons.ppt;
    }
    if (filename.endsWith('xls') || filename.endsWith('xlsx')) {
      return CarbonIcons.xls;
    }
    if (filename.endsWith('zip')) {
      return CarbonIcons.zip;
    }
    if (filename.endsWith('txt')) {
      return CarbonIcons.txt;
    }
    if (filename.endsWith('jpg') ||
        filename.endsWith('jpeg') ||
        filename.endsWith('png') ||
        filename.endsWith('gif') ||
        filename.endsWith('bmp') ||
        filename.endsWith('webp')) {
      return CarbonIcons.image;
    }
    return Icons.attachment;
  }

  bool isSupportedFile(String filePath) {
    // Define supported file extensions
    const supportedExtensions = [
      'jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', // Image files
      'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', // Office files
      'pdf', // PDF files
      'zip', // Zip files
      'txt' // Text files
    ];

    // Get the file extension
    final fileExtension = filePath.split('.').last.toLowerCase();

    // Check if the file extension is in the list of supported extensions
    return supportedExtensions.contains(fileExtension);
  }
}

final fileService = _FileService();
