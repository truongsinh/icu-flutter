import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icu/icu.dart';

void main() {
  const MethodChannel channel = MethodChannel('icu');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Icu.platformVersion, '42');
  });
}
