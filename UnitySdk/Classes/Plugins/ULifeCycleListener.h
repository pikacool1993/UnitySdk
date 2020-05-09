#pragma once

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// important app life-cycle events

@protocol ULifeCycleListener<NSObject>
@optional
- (void)didFinishLaunching:(NSNotification*)notification;
- (void)didBecomeActive:(NSNotification*)notification;
- (void)willResignActive:(NSNotification*)notification;
- (void)didEnterBackground:(NSNotification*)notification;
- (void)willEnterForeground:(NSNotification*)notification;
- (void)willTerminate:(NSNotification*)notification;
@end

void UnityRegisterLifeCycleListener(id<ULifeCycleListener> obj);
void UnityUnregisterLifeCycleListener(id<ULifeCycleListener> obj);
