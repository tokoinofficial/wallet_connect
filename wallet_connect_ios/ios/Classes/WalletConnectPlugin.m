#import "WalletConnectPlugin.h"
#if __has_include(<wallet_connect_ios/wallet_connect_ios-Swift.h>)
#import <wallet_connect_ios/wallet_connect_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wallet_connect_ios-Swift.h"
#endif

@implementation WalletConnectPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    [WalletConnectSwiftPlugin registerWithRegistrar:registrar];
}

@end
