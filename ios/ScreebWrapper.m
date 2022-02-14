//
//  ScreebWrapper.m
//  ScreebReactDemoApp
//
//  Created by Quaquin Clément on 13/12/2021.
//
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_REMAP_MODULE(ScreebModule, ScreebWrapper, NSObject)
RCT_EXTERN_METHOD(initScreeb:(UIViewController *)context)
RCT_EXTERN_METHOD(setIdentity:(NSString *)userId properties:(NSDictionary<NSString *, id> *)properties_)
RCT_EXTERN_METHOD(trackEvent:(NSString *)eventId properties:(NSDictionary<NSString *, id> *)properties_)
RCT_EXTERN_METHOD(trackScreen:(NSString *)screen properties:(NSDictionary<NSString *, id> *)properties_)
RCT_EXTERN_METHOD(setProperties:(NSDictionary<NSString *, id> *)properties)
+ (BOOL)requiresMainQueueSetup
{
  return YES;
}
@end
