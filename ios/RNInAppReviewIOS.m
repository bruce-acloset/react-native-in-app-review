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
  return @{
    @"isAvailable": [SKStoreReviewController class] ? @(YES) : @(NO)
  };
}

RCT_EXPORT_METHOD(requestReview:
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
      
  
  
  if (@available(iOS 14, *)) {
         [self logMessage:@"iOS 14+"];
         UIWindowScene *scene = [self findActiveScene];
         if (scene) {
             [self logMessage:@"scene found"];
             [SKStoreReviewController requestReviewInScene:scene];
             result(nil);
         } else {
             [self logMessage:@"scene not found"];
           result(nil);
         }
     } else if (@available(iOS 10.3, *)) {
         [self logMessage:@"iOS 10.3+"];
         [SKStoreReviewController requestReview];
         result(nil);
     } else {
       result(nil);
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
