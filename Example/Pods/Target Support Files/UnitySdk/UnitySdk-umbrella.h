#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UAppDelegateListener.h"
#import "ULifeCycleListener.h"
#import "UUnityViewControllerListener.h"
#import "UApplication.h"
#import "UKit.h"
#import "BitchApplication.h"
#import "BitchDevice.h"

FOUNDATION_EXPORT double UnitySdkVersionNumber;
FOUNDATION_EXPORT const unsigned char UnitySdkVersionString[];

