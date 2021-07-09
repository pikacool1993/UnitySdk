//
//  UApplication.m
//  Unity-iPhone
//
//  Created by a on 2020/5/8.
//

#import "UApplication.h"

#import <AdSupport/AdSupport.h>
#if defined(__IPHONE_14_0)
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#endif

@interface UApplication ()

@end

@implementation UApplication

+ (instancetype)sharedApplication {
    static dispatch_once_t onceToken;
    static UApplication *application = nil;
    dispatch_once(&onceToken,^{
        application = [[self alloc] init];
    });
    return application;
}

#pragma mark - AppDelegate


#pragma mark - LifeCycle
- (void)applicationFinishLaunching:(UIApplication *)application {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            //建议在这个回调后，再进行广告的加载，以便于三方渠道使用IDFA
        }];
    }
}

- (void)applicationBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
