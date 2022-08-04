import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secverify_plugin/secverify.dart';

void main() {
  const MethodChannel channel = MethodChannel('secverify');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Secverify.platformVersion, '42');
  });
}
