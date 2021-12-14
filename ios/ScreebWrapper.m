//
//  ScreebWrapper.m
//  ScreebReactDemoApp
//
//  Created by Quaquin Clément on 13/12/2021.
//
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_REMAP_MODULE(ScreebModule, ScreebWrapper, NSObject)
RCT_EXTERN_METHOD(setIdentity:(NSString *)userId)
RCT_EXTERN_METHOD(trackEvent:(NSString *)eventId)
RCT_EXTERN_METHOD(trackScreen:(NSString *)screen)
RCT_EXTERN_METHOD(setVisitorProperties:(NSDictionary<NSString *, id> *)properties)
+ (BOOL)requiresMainQueueSetup
{
  return YES;
}
@end
