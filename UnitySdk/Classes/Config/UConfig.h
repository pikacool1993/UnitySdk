//
//  UConfig.h
//  Pods-UnitySdk_Example
//
//  Created by a on 2020/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define UConfigJsonFileName @"unity_config.json"

@interface UIronSourceConfig : NSObject

@property (nonatomic, strong) NSString *app_key;

@property (nonatomic, strong) NSDictionary *ad_units;

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface UFacebookConfig : NSObject

@property (nonatomic, strong) NSString *app_key;

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface UAppsflyerConfig : NSObject

@property (nonatomic, strong) NSString *app_key;

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface UConfig : NSObject

@property (nonatomic, strong) NSString *applestore_id;

@property (nonatomic, strong) UIronSourceConfig *ironsource;

@property (nonatomic, strong) UFacebookConfig *facebook;

@property (nonatomic, strong) UAppsflyerConfig *appsflyer;

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
