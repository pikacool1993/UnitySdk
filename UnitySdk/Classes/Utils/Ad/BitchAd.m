//
//  BitchAd.m
//  FBSDKCoreKit
//
//  Created by a on 2021/4/7.
//

#import "BitchAd.h"

@implementation BitchAd

+ (instancetype)shared {
    static BitchAd *ad = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ad = [[self alloc] init];
    });
    return ad;
}

- (BOOL)isInterstitialAdReady {
    return NO;
}

- (BOOL)isRewardedAdReady {
    return NO;
}

- (void)loadInterstitialAd {
    
}

- (void)loadRewardedAd {
    
}

- (void)showInterstitialAd {
    
}

- (void)showRewaredAd {
    
}

@end
