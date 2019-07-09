import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supreme_handler/supreme_handler.dart';

void main() {
  const MethodChannel channel = MethodChannel('supreme_handler');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('clearCookies', () async {
    expect(await SupremeHandler.clearCookies, true);
  });
}
