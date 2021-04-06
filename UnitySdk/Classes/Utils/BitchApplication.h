//
//  BitchApplication.h
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BitchApplication : NSObject

+ (NSString *)applicationName;

+ (NSString *)applicationBundleId;

+ (NSString *)applicationVersion;

+ (NSString *)applicationBuildVersion;

+ (UIViewController *)presentingVc;

@end

NS_ASSUME_NONNULL_END
