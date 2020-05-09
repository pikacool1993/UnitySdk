//
//  PMDevice.h
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMDevice : NSObject

/**
* 获取当前设备是否是全面屏
* e.g.
@return 是否是全面屏
*/
+ (BOOL)isFullScreen;

/**
* 获取当前设备是否越狱
* e.g.
@return 是否越狱
*/
+ (BOOL)isJailbreak;

/**
* 获取当前设备屏幕尺寸
* e.g. {750, 1334}
@return 当前设备屏幕尺寸
*/
+ (CGSize)screenSize;

/**
* 获取当前设备用户设置的名称，设置->通用->关于本机->名称
* e.g. "My iPhone"
@return 用户设置的本机名称
*/
+ (NSString *)deviceName;

/**
* 获取当前的APP的运行的手机系统版本号
* e.g. @"9.3.5"
@return 系统版本
*/
+ (NSString *)deviceSystenVersion;

/**
* 获取当前设备的手机系统名称
* e.g. @"iOS"
@return 手机系统名称
*/
+ (NSString *)deviceSystenName;

/**
* 获取当前设备类型名称
* e.g. @"iPhone", @"iPod touch", @"iPad"
@return 设备类型的名称
*/
+ (NSString *)deviceModel;

/**
* 获取当前设备语言
* e.g. @"en_Zh"
@return 设备语言
*/
+ (NSString *)deviceLanguage;

/**
* 获取当前设备局域网IP
* e.g. @"192.168.1.1"
@return 局域网IP
*/
+ (NSString *)deviceLocalIP;

/**
* 获取当前设备是否使用网络代理
* e.g. @"NO"
@return 是否使用网络代理
*/
+ (BOOL)isUseProxy;

@end

NS_ASSUME_NONNULL_END
