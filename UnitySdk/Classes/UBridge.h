//
//  UBridge.h
//  Unity-iPhone
//
//  Created by a on 2020/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBridge : NSObject

typedef void(BitchLoginCallback)(const char *result, int errorCode, const char *errorMsg);

extern "C" {
    char* _ApplicationName();
    char* _ApplicationBundleId();
    char* _ApplicationVersion();
    char* _ApplicationBuildVersion();
    bool _IsFullScreen();
    bool _IsJailbreak();
    
    void _LoginWithApple(BitchLoginCallback);
    void _LoginWithFacebook(BitchLoginCallback);
    
    void _RateUs();
    
    bool _IsInterstitialAdReady();
    bool _IsRewardedAdReady();
    void _LoadInterstitialAd();
    void _LoadRewardedAd();
    void _ShowInterstitialAd();
    void _ShowRewaredAd();
}

@end

NS_ASSUME_NONNULL_END
