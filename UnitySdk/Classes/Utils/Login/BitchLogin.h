//
//  BitchLogin.h
//  UnitySdk
//
//  Created by a on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 用户主动取消
    BitchLoginResultUserCancel = 90001,
    /// 系统错误
    BitchLoginResultSystemError = 90002,
    /// 未知错误
    BitchLoginResultUnknown = 90003
} BitchLoginResult;

typedef void (^BitchLoginBlock)(NSString * _Nullable resultJson, NSInteger errorCode, NSString * _Nullable errorMsg);

@interface BitchLogin : NSObject

+ (instancetype)shared;

/// Apple 登录
/// @param loginBlock 登录回调
- (void)loginWithApple:(BitchLoginBlock)loginBlock;

/// Facebook
/// @param loginBlock Facebook登录
- (void)loginWithFacebook:(BitchLoginBlock)loginBlock;

@end

NS_ASSUME_NONNULL_END
