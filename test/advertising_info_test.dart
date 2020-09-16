import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advertising_info/advertising_info.dart';

void main() {
  const MethodChannel channel = MethodChannel('advertising_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return { "id": '42', "isLimitAdTrackingEnabled": false } ;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getAdvertisingInfo', () async {
    var adInfo = await AdvertisingInfo.read();
    expect(adInfo.id, '42');
    expect(adInfo.isLimitAdTrackingEnabled, false);
  });
}
