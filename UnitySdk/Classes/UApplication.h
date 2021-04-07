//
//  UApplication.h
//  Unity-iPhone
//
//  Created by a on 2020/5/8.
//

#import <Foundation/Foundation.h>
#import "UConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface UApplication : NSObject

@property (nonatomic, strong) UConfig *config;

+ (instancetype)sharedApplication;

#pragma mark - AppDelegate

#pragma mark - LifeCycle
- (void)applicationFinishLaunching:(UIApplication *)application;
- (void)applicationBecomeActive:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
@end

NS_ASSUME_NONNULL_END
