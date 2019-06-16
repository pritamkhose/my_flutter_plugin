#import "MyFlutterPlugin.h"
#import <my_flutter_plugin/my_flutter_plugin-Swift.h>

@implementation MyFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyFlutterPlugin registerWithRegistrar:registrar];
}
@end
