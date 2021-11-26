import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:own_notify/own_notify.dart';

void main() {
  const MethodChannel channel = MethodChannel('own_notify');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

/*  test('getPlatformVersion', () async {
    expect(await OwnNotify.platformVersion, '42');
  });*/
}
