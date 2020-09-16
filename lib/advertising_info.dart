import 'dart:async';

import 'package:flutter/services.dart';

class AdvertisingInfo {
  final String id;
  final bool isLimitAdTrackingEnabled;
  final AdTrackingAuthorizationStatus authorizationStatus;

  AdvertisingInfo(this.id, this.isLimitAdTrackingEnabled, this.authorizationStatus);

  static const MethodChannel _channel = const MethodChannel('advertising_info');

  static Future<AdvertisingInfo> read() async {
    final Map<String, dynamic> map = await _channel.invokeMapMethod<String, dynamic>('getAdvertisingInfo');
    return AdvertisingInfo(map["id"], map["isLimitAdTrackingEnabled"], convertAuthorizationStatus(map["authorizationStatus"]));
  }

  static Future<AdTrackingAuthorizationStatus> requestAuthorization() async {
    final int statusValue = await _channel.invokeMethod('requestAuthorization');
    return convertAuthorizationStatus(statusValue);
  }
}

enum AdTrackingAuthorizationStatus {
  notDetermined,
  restricted,
  denied,
  authorized
}

convertAuthorizationStatus(int value) {
  switch(value) {
    case 1:
      return AdTrackingAuthorizationStatus.restricted;
    case 2:
      return AdTrackingAuthorizationStatus.denied;
    case 3:
      return AdTrackingAuthorizationStatus.authorized;
    case 0:
    default:
      return AdTrackingAuthorizationStatus.notDetermined;
  }
}