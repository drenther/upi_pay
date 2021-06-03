#import "UpiPayPlugin.h"
#if __has_include(<upi_pay/upi_pay-Swift.h>)
#import <upi_pay/upi_pay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "upi_pay-Swift.h"
#endif

@implementation UpiPayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUpiPayPlugin registerWithRegistrar:registrar];
}
@end
