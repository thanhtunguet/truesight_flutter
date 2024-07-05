import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

extension TrueSightCookieJar on PersistCookieJar {
  static Future<PersistCookieJar> init() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final documentsPath = documentsDir.path;

    return PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(documentsPath),
      persistSession: true,
    );
  }
}
