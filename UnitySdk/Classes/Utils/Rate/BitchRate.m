//
//  BitchRate.m
//  UnitySdk
//
//  Created by a on 2021/4/6.
//

#import "BitchRate.h"

#import <StoreKit/SKStoreReviewController.h>

@implementation BitchRate

+ (instancetype)shared {
    static BitchRate *rate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rate = [[self alloc] init];
    });
    return rate;
}

- (void)rate {
    if (@available(iOS 10.3, *)) {
       if ([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
           [SKStoreReviewController requestReview];
       }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://apps.apple.com/app/id" stringByAppendingString:@""]]];
    }
}

@end
