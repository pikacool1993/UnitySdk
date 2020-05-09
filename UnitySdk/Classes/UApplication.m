//
//  UApplication.m
//  Unity-iPhone
//
//  Created by a on 2020/5/8.
//

#import "UApplication.h"
#import <UMCommon/UMCommon.h>

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
    [UMConfigure initWithAppkey:@"5eb4b2a9570df3494c000041" channel:@"App Store"];
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
