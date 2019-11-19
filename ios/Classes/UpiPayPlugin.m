#import "UpiPayPlugin.h"
#import <upi_pay/upi_pay-Swift.h>

@implementation UpiPayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUpiPayPlugin registerWithRegistrar:registrar];
}
@end
