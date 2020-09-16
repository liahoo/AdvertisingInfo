import Flutter
import UIKit
import AdSupport

import AppTrackingTransparency

public class SwiftAdvertisingInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "advertising_info", binaryMessenger: registrar.messenger())
    let instance = SwiftAdvertisingInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getAdvertisingInfo":
        let manager = ASIdentifierManager.shared()
        let idfaString = manager.advertisingIdentifier.uuidString
        var authorizationStatus = UInt(0)
        var isLAT: Bool = false
        if #available(iOS 14, *) {
            authorizationStatus = ATTrackingManager.self.trackingAuthorizationStatus.rawValue
            switch ATTrackingManager.self.trackingAuthorizationStatus {
            case ATTrackingManager.AuthorizationStatus.denied: isLAT = true
            case ATTrackingManager.AuthorizationStatus.restricted: isLAT = true
            case ATTrackingManager.AuthorizationStatus.notDetermined: isLAT = false
            case ATTrackingManager.AuthorizationStatus.authorized: isLAT = false
            default: isLAT = false
            }
        } else {
            isLAT = manager.isAdvertisingTrackingEnabled
        }
        result(["id":idfaString, "isLimitAdTrackingEnabled":isLAT, "authorizationStatus": authorizationStatus])
    default:
        result(nil)
    }
  }
}
