//
//  UBridge.h
//  Unity-iPhone
//
//  Created by a on 2020/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBridge : NSObject

extern "C" {
    char* _ApplicationName();
    char* _ApplicationBundleId();
    char* _ApplicationVersion();
    char* _ApplicationBuildVersion();
    bool _IsFullScreen();
    bool _IsJailbreak();
    
    void _LoginWithApple();
    void _LoginWithFacebook();
    
    void _RateUs();
}

@end

NS_ASSUME_NONNULL_END
