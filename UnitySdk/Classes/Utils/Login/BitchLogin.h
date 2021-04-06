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

typedef void (^BitchAppleLoginBlock)(id _Nullable result, NSError * _Nullable error);
typedef void (^BitchFacebookLoginBlock)(id _Nullable result, NSError * _Nullable error);

@interface BitchLogin : NSObject

+ (instancetype)shared;

/// Apple 登录
/// @param loginBlock 登录回调
- (void)loginWithApple:(BitchAppleLoginBlock)loginBlock;

/// Facebook
/// @param loginBlock Facebook登录
- (void)loginWithFackbook:(BitchFacebookLoginBlock)loginBlock;

@end

NS_ASSUME_NONNULL_END
