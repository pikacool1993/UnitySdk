//
//  UBridge.m
//  Unity-iPhone
//
//  Created by a on 2020/5/9.
//

#import "UBridge.h"

#import <UnitySdk/PMDevice.h>
#import <UnitySdk/PMApplication.h>

// Converts NSString to C style string by way of copy (Mono will free it)
#define MakeStringCopy( _x_ ) ( _x_ != NULL && [_x_ isKindOfClass:[NSString class]] ) ? strdup( [_x_ UTF8String] ) : strdup( [@"" UTF8String] )
// Converts C style string to NSString
#define GetStringParam( _x_ ) ( _x_ != NULL ) ? [NSString stringWithUTF8String:_x_] : [NSString stringWithUTF8String:""]
// Converts C style string to NSString as long as it isnt empty
#define GetStringParamOrNil( _x_ ) ( _x_ != NULL && strlen( _x_ ) ) ? [NSString stringWithUTF8String:_x_] : nil

@implementation UBridge

@end

extern const char* _ApplicationName() {
    NSString *appName = [PMApplication applicationName];
    return MakeStringCopy(appName);
}

extern const char* _ApplicationBundleId() {
    NSString *bundleId = [PMApplication applicationBundleId];
    return MakeStringCopy(bundleId);
}

extern const char* _ApplicationVersion() {
    NSString *appVersion = [PMApplication applicationVersion];
    return MakeStringCopy(appVersion);
}

extern const char* _ApplicationBuildVersion() {
    NSString *appBuildVersion = [PMApplication applicationBuildVersion];
    return MakeStringCopy(appBuildVersion);
}

extern const bool _IsFullScreen() {
    bool fullScreen = [PMDevice isFullScreen] ? true : false;
    return fullScreen;
}

extern const bool _IsJailbreak() {
    bool jailbreak = [PMDevice isJailbreak] ? true : false;
    return jailbreak;
}
