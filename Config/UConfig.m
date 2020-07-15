//
//  UConfig.m
//  Pods-UnitySdk_Example
//
//  Created by a on 2020/7/15.
//

#import "UConfig.h"

@implementation UIronSourceConfig

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UIronSourceConfig *config = [[UIronSourceConfig alloc] init];
    [config setValuesForKeysWithDictionary:dictionary];
    return config;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation UFacebookConfig

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UFacebookConfig *config = [[UFacebookConfig alloc] init];
    [config setValuesForKeysWithDictionary:dictionary];
    return config;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation UAppsflyerConfig

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UAppsflyerConfig *config = [[UAppsflyerConfig alloc] init];
    [config setValuesForKeysWithDictionary:dictionary];
    return config;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation UConfig

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UConfig *config = [[UConfig alloc] init];
    [config setValuesForKeysWithDictionary:dictionary];
    return config;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
