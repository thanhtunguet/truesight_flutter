import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

void main() {
  test('number formats', () async {
    const num n = 1003565.45;
    const double d = 1005634.4;
    const int i = 1005634;
    debugPrint(n.asMoney());
    debugPrint(d.asMoney());
    debugPrint(i.asMoney());
  });
}
