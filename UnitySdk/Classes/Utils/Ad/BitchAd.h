//
//  BitchAd.h
//  FBSDKCoreKit
//
//  Created by a on 2021/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BitchAd : NSObject

+ (instancetype)shared;

- (BOOL)isInterstitialAdReady;

- (BOOL)isRewardedAdReady;

- (void)loadInterstitialAd;

- (void)loadRewardedAd;

- (void)showInterstitialAd;

- (void)showRewaredAd;

@end

NS_ASSUME_NONNULL_END
