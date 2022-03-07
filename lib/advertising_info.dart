import 'dart:async';

import 'package:flutter/services.dart';

class AdvertisingInfo {
  /// advertising id (IDFA for iOS, GAID for Android)
  final String? id;
  /// if user has limited Ad tracking or not.
  final bool? isLimitAdTrackingEnabled;
  /// authorization status by users. (mainly for iOS14)
  final AdTrackingAuthorizationStatus? authorizationStatus;

  AdvertisingInfo(
      this.id, this.isLimitAdTrackingEnabled, this.authorizationStatus);

  static const MethodChannel _channel = const MethodChannel('advertising_info');

  static Future<AdvertisingInfo> read() async {
    final Map<String, dynamic>? map =
        await _channel.invokeMapMethod<String, dynamic>('getAdvertisingInfo');
    return AdvertisingInfo(map?["id"], map?["isLimitAdTrackingEnabled"],
        convertAuthorizationStatus(map?["authorizationStatus"]));
  }
}

/// authorization status by users. (mainly for iOS14)
enum AdTrackingAuthorizationStatus {
  notDetermined,
  restricted,
  denied,
  authorized
}

convertAuthorizationStatus(int? value) {
  switch (value) {
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
