//
//  UApplication.m
//  Unity-iPhone
//
//  Created by a on 2020/5/8.
//

#import "UApplication.h"
#import "UConfig.h"
#import <IronSource/IronSource.h>

@interface UApplication ()
@property (nonatomic, strong) UConfig *config;
@end

@implementation UApplication

+ (instancetype)sharedApplication {
    static dispatch_once_t onceToken;
    static UApplication *application = nil;
    dispatch_once(&onceToken,^{
        application = [[self alloc] init];
        // 读配置
        [application initConfig];
    });
    return application;
}

- (void)initConfig {
    NSString *path = [[NSBundle mainBundle] pathForResource:UConfigJsonFileName ofType:nil];
    
    NSError *error;
    NSString *configJsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        NSData *configJsonData = [configJsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *configDict = [NSJSONSerialization JSONObjectWithData:configJsonData options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            self.config = [UConfig initWithDictionary:configDict];
        } else {
            
        }
    } else {
        
    }
}

#pragma mark - AppDelegate


#pragma mark - LifeCycle
- (void)applicationFinishLaunching:(UIApplication *)application {
    // Set IronSource Delegate
    
    // Init IronSource
    [IronSource initWithAppKey:self.config.ironsource.app_key adUnits:self.config.ironsource.ad_units.allKeys];
}

- (void)applicationBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
