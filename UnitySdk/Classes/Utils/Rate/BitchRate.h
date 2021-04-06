//
//  BitchRate.h
//  UnitySdk
//
//  Created by a on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BitchRate : NSObject

+ (instancetype)shared;

- (void)rate;

@end

NS_ASSUME_NONNULL_END
