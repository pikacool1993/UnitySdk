//
//  PMDevice.m
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import "PMDevice.h"

@implementation PMDevice

+ (BOOL)isFullScreen {
    BOOL iPhoneX = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812));
    BOOL iPhoneXR = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896));
    BOOL iPhoneXMax = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896));
    return (iPhoneX || iPhoneXR || iPhoneXMax);
}

+ (BOOL)isJailbreak {
    static BOOL isJailbreak = NO;
    if (isJailbreak) {
        return isJailbreak;
    }
    @try {
        NSArray *paths = [NSArray arrayWithObjects:
                          @"/User/Applications/",
                          @"/Applications/Cydia.app",
                          @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                          @"/bin/bash",
                          @"/usr/sbin/sshd",
                          @"/etc/apt",
                          nil];
        
        for (NSString *path in paths) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                isJailbreak = YES;
                break;
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"Jailbroken exception:%@",exception);
    }
    return isJailbreak;
}

+ (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)deviceSystenVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceSystenName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceLanguage {
    return @"";
}

+ (NSString *)deviceLocalIP {
    return @"";
}



@end
