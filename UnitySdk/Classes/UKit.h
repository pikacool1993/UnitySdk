//
//  UKit.h
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UnitySdk/UAppDelegateListener.h>
#import <UnitySdk/ULifeCycleListener.h>

@interface UKit : NSObject <UAppDelegateListener, ULifeCycleListener>

+ (instancetype)shared;

@end
