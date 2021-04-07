//
//  UBridge.m
//  Unity-iPhone
//
//  Created by a on 2020/5/9.
//

#import "UBridge.h"

#import <UnitySdk/BitchDevice.h>
#import <UnitySdk/BitchApplication.h>
#import <UnitySdk/BitchLogin.h>
#import <UnitySdk/BitchRate.h>
#import <UnitySdk/BitchAd.h>

// Converts NSString to C style string by way of copy (Mono will free it)
#define MakeStringCopy( _x_ ) ( _x_ != NULL && [_x_ isKindOfClass:[NSString class]] ) ? strdup( [_x_ UTF8String] ) : strdup( [@"" UTF8String] )
// Converts C style string to NSString
#define GetStringParam( _x_ ) ( _x_ != NULL ) ? [NSString stringWithUTF8String:_x_] : [NSString stringWithUTF8String:""]
// Converts C style string to NSString as long as it isnt empty
#define GetStringParamOrNil( _x_ ) ( _x_ != NULL && strlen( _x_ ) ) ? [NSString stringWithUTF8String:_x_] : nil

@implementation UBridge

#pragma mark - Basic DeviceInfo
char* _ApplicationName() {
    NSString *appName = [BitchApplication applicationName];
    return MakeStringCopy(appName);
}

char* _ApplicationBundleId() {
    NSString *bundleId = [BitchApplication applicationBundleId];
    return MakeStringCopy(bundleId);
}

char* _ApplicationVersion() {
    NSString *appVersion = [BitchApplication applicationVersion];
    return MakeStringCopy(appVersion);
}

char* _ApplicationBuildVersion() {
    NSString *appBuildVersion = [BitchApplication applicationBuildVersion];
    return MakeStringCopy(appBuildVersion);
}

bool _IsFullScreen() {
    bool fullScreen = [BitchDevice isFullScreen] ? true : false;
    return fullScreen;
}

bool _IsJailbreak() {
    bool jailbreak = [BitchDevice isJailbreak] ? true : false;
    return jailbreak;
}

#pragma mark - Login
void _LoginWithApple(BitchLoginCallback callback) {
    [[BitchLogin shared] loginWithApple:^(NSString * _Nullable resultJson, NSInteger errorCode, NSString * _Nullable errorMsg) {
        int code = (int)errorCode;
        callback(MakeStringCopy(resultJson), code, MakeStringCopy(errorMsg));
    }];
}

void _LoginWithFacebook(BitchLoginCallback callback) {
    [[BitchLogin shared] loginWithFacebook:^(NSString * _Nullable resultJson, NSInteger errorCode, NSString * _Nullable errorMsg) {
        int code = (int)errorCode;
        callback(MakeStringCopy(resultJson), code, MakeStringCopy(errorMsg));
    }];
}

void _RateUs() {
    [[BitchRate shared] rate];
}

#pragma mark - Ads
bool _IsInterstitialAdReady() {
    return [BitchAd shared].isInterstitialAdReady ? true : false;
}

bool _IsRewardedAdReady() {
    return [BitchAd shared].isRewardedAdReady ? true : false;
}

void _LoadInterstitialAd() {
    [[BitchAd shared] loadInterstitialAd];
}

void _LoadRewardedAd() {
    [[BitchAd shared] loadRewardedAd];
}

void _ShowInterstitialAd() {
    [[BitchAd shared] showInterstitialAd];
}

void _ShowRewaredAd() {
    [[BitchAd shared] showRewaredAd];
}

@end








