#import "RNInAppReviewIOS.h"
#import <StoreKit/SKStoreReviewController.h>

@implementation RNInAppReviewIOS


- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    if (@available(iOS 10.3, *)) {
        return @{
            @"isAvailable": [SKStoreReviewController class] ? @(YES) : @(NO)
  };
  } else {
      // Fallback on earlier versions
      return @(NO);
  }
}

RCT_EXPORT_METHOD(requestReview:
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
      
  
  
  if (@available(iOS 14, *)) {
         UIWindowScene *scene = [self findActiveScene];
         if (scene) {
             [SKStoreReviewController requestReviewInScene:scene];
         }
     } else if (@available(iOS 10.3, *)) {
         [SKStoreReviewController requestReview];
     }
}

- (UIWindowScene *) findActiveScene  API_AVAILABLE(ios(13.0)){
    for (UIWindowScene *scene in UIApplication.sharedApplication.connectedScenes) {
        
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            return scene;
        }
        
    }
    
    return nil;
}



+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end
