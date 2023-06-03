import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/truesight_flutter.dart';
import 'package:truesight_flutter/truesight_flutter_platform_interface.dart';
import 'package:truesight_flutter/truesight_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTruesightFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TruesightFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TruesightFlutterPlatform initialPlatform = TruesightFlutterPlatform.instance;

  test('$MethodChannelTruesightFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTruesightFlutter>());
  });

  test('getPlatformVersion', () async {
    TruesightFlutter truesightFlutterPlugin = TruesightFlutter();
    MockTruesightFlutterPlatform fakePlatform = MockTruesightFlutterPlatform();
    TruesightFlutterPlatform.instance = fakePlatform;

    expect(await truesightFlutterPlugin.getPlatformVersion(), '42');
  });
}
