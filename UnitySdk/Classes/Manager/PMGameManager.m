//
//  PMGameManager.m
//  UnitySdk_Example
//
//  Created by a on 2020/5/8.
//  Copyright © 2020 pikacool1993. All rights reserved.
//

#import "PMGameManager.h"

@implementation PMGameManager

+ (void)load {
    [PMGameManager sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static PMGameManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"游戏SDK初始化");
    }
    return self;
}

@end
