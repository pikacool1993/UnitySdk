//
//  UKit.m
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import "UKit.h"
#import "UApplication.h"

@interface UKit ()

@property (nonatomic, strong) UApplication *uDelegate;

@end

@implementation UKit

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static UKit *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)load {
    UnityRegisterAppDelegateListener([UKit shared]);
}

- (void)dealloc {
    UnityUnregisterAppDelegateListener([UKit shared]);
}

#pragma mark - AppDelegateListener


#pragma mark - LifeCycleListener
- (void)didFinishLaunching:(NSNotification *)notification {
    if (notification.object && [notification.object isKindOfClass:[UIApplication class]]) {
        [[UApplication sharedApplication] applicationFinishLaunching:notification.object];
    }
}

- (void)didBecomeActive:(NSNotification *)notification {
    if (notification.object && [notification.object isKindOfClass:[UIApplication class]]) {
        [[UApplication sharedApplication] applicationBecomeActive:notification.object];
    }
}

- (void)willResignActive:(NSNotification *)notification {
    if (notification.object && [notification.object isKindOfClass:[UIApplication class]]) {
        [[UApplication sharedApplication] applicationWillResignActive:notification.object];
    }
}

- (void)didEnterBackground:(NSNotification *)notification {
    if (notification.object && [notification.object isKindOfClass:[UIApplication class]]) {
        [[UApplication sharedApplication] applicationEnterBackground:notification.object];
    }
}

- (void)willEnterForeground:(NSNotification *)notification {
    if (notification.object && [notification.object isKindOfClass:[UIApplication class]]) {
        [[UApplication sharedApplication] applicationWillEnterForeground:notification.object];
    }
}

- (void)willTerminate:(NSNotification *)notification {
    if (notification.object && [notification.object isKindOfClass:[UIApplication class]]) {
        [[UApplication sharedApplication] applicationWillTerminate:notification.object];
    }
}

@end
