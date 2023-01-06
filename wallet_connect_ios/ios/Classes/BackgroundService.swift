//
//  BackgroundService.swift
//  wallet_connect_ios
//
//  Created by Yoyo on 06/01/2023.
//

import Foundation
import Flutter

class BackgroundService {
    func runService(callbackDispatcherHandle: Int64, callbackHandle: Int64) {
        print("runService")
        guard
            let flutterCallbackInformation = FlutterCallbackCache.lookupCallbackInformation(callbackDispatcherHandle) else {
            return
        }
        print("runService 1")
        var flutterEngine: FlutterEngine? = FlutterEngine(name: "BGThread", project: nil, allowHeadlessExecution: true)
        
        flutterEngine!.run(withEntrypoint: flutterCallbackInformation.callbackName, libraryURI: flutterCallbackInformation.callbackLibraryPath)
        
        var mBackgroundChannel: FlutterMethodChannel? = FlutterMethodChannel(name: "background_channel", binaryMessenger: flutterEngine!.binaryMessenger)
        
        func cleanupFlutterResources() {
            flutterEngine?.destroyContext()
            mBackgroundChannel = nil
            flutterEngine = nil
        }
        
        mBackgroundChannel?.invokeMethod("", arguments: [
            callbackHandle, "Hello, I am transferred from swift to dart world"], result: { _ in
                cleanupFlutterResources()
            })
    }
}
