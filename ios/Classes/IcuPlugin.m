#import "IcuPlugin.h"
#import <icu/icu-Swift.h>

@implementation IcuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIcuPlugin registerWithRegistrar:registrar];
}
@end
