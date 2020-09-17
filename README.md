# advertising_info

A Flutter plugin for fetching Advertising info from Android and iOS
## Usage

1. Add `advertising_info` to your package's pubspec.yaml file:
1. Get package by `$ flutter pub get`


## Getting Started

Import it to your source code
```dart
import 'package:advertising_info/advertising_info.dart';
```

Call  `AdvertisingInfo.read();` to get Advertising info from platform(iOS or Android)
```dart
AdvertisingInfo advertisingInfo = await AdvertisingInfo.read();
```

Call `AdvertisingInfo.id` to get advertising id (IDFA for iOS, GAID for Android)

```dart
String advertising_id = advertisingInfo.id
```

Call `AdvertisingInfo.isLimitAdTrackingEnabled` to check if user has limited Ad tracking or not.
```dart
Bool isLAT = advertisingInfo.isLimitAdTrackingEnabled
```
- false: Ad Tracking is not limited (Able to get advertising id)
- true: Ad Tracking is limited (Unable to get advertising id)

Call `AdvertisingInfo.authorizationStatus` to check authorization status by users. (mainly for iOS14)
```dart
AauthorizationStatus status = advertisingInfo.authorizationStatus
```

`AauthorizationStatus` is an enum with values below
```dart
enum AdTrackingAuthorizationStatus {
  notDetermined,
  restricted,
  denied,
  authorized
}
```
