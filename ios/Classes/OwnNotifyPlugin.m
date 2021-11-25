#import "OwnNotifyPlugin.h"
#if __has_include(<own_notify/own_notify-Swift.h>)
#import <own_notify/own_notify-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "own_notify-Swift.h"
#endif

@implementation OwnNotifyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOwnNotifyPlugin registerWithRegistrar:registrar];
}
@end
