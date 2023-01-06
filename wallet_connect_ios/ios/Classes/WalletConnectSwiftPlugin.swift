//
//  WalletConnectSwiftPlugin.swift
//  wallet_connect_ios
//
//  Created by Yoyo on 06/01/2023.
//

import Flutter
import UIKit

public class WalletConnectSwiftPlugin: NSObject, FlutterPlugin {

    var mCallbackDispatcherHandle: Int64 = 0

  public static func register(with registrar: FlutterPluginRegistrar) {
    print("register")
    let channel = FlutterMethodChannel(name: "wallet_connect_ios", binaryMessenger: registrar.messenger())
    let instance = WalletConnectSwiftPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print(call.method)
    switch call.method {
    case "initializeForBackground":
        guard let args = call.arguments as? [Int], args.count != 0 else  {
            return
        }
        
        let callbackHandle = Int64(args[0])
        mCallbackDispatcherHandle = callbackHandle
        
        result(nil)
      case "callBackgroundService":
        guard let args = call.arguments as? [Int], args.count != 0 else  {
            return
        }
        
        let callbackHandle = Int64(args[0])
        
        let service = BackgroundService()
        service.runService(callbackDispatcherHandle: mCallbackDispatcherHandle, callbackHandle: callbackHandle)
        
        result(nil)
    case "getPlatformName":
        result("iOS " + UIDevice.current.systemVersion)
    default:
      print("not Implemented")
    }
  }
}
