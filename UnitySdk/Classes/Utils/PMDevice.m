//
//  PMDevice.m
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import "PMDevice.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

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
    return [[NSLocale currentLocale] localeIdentifier];;
}

+ (NSString *)deviceLocalIP {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP)) {
                continue;
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    
    NSArray *searchArray = @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
         address = addresses[key];
         if(address) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isUseProxy {
    CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
    NSDictionary *dictProxy = (__bridge  id)proxySettings;
    BOOL isUseProxy = [[dictProxy objectForKey:@"HTTPEnable"] boolValue];
    CFRelease(proxySettings);
    return isUseProxy;
}


@end
