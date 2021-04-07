//
//  BitchLogin.m
//  UnitySdk
//
//  Created by a on 2021/4/6.
//

#import "BitchLogin.h"

#import <UnitySdk/BitchApplication.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface BitchLogin () <ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate>

@property (nonatomic, copy) void (^appleLoginBlock)(id _Nullable result, NSError  * _Nullable error);

@end

@implementation BitchLogin

+ (instancetype)shared {
    static BitchLogin *login = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[self alloc] init];
    });
    return login;
}

- (void)loginWithApple:(BitchAppleLoginBlock)loginBlock API_AVAILABLE(ios(13.0)) {
    if (!loginBlock) {
        return;
    }
    
    self.appleLoginBlock = loginBlock;
    
    ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *request = [provider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    
    ASAuthorizationController *vc = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    vc.delegate = self;
    vc.presentationContextProvider = self;
    [vc performRequests];
}

- (void)loginWithFackbook:(BitchFacebookLoginBlock)loginBlock {
    FBSDKAccessToken *facebookToken = [FBSDKAccessToken currentAccessToken];
    if (facebookToken.tokenString && [facebookToken.expirationDate compare:[NSDate date]] != NSOrderedAscending) {
        [self fetchFaceBookUserinfoWithCallBack:loginBlock];
        return;
    }
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithPermissions:@[@"public_profile", @"email"] fromViewController:[BitchApplication presentingVc] handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            loginBlock(nil, error);
        } else {
            if (result.isCancelled) {
                loginBlock(nil, [NSError errorWithDomain:@"FacebookLogin" code:BitchLoginResultUserCancel userInfo:@{NSLocalizedDescriptionKey : @"ErrorCanceled"}]);
            } else {
                [self fetchFaceBookUserinfoWithCallBack:loginBlock];
            }
        }
    }];
}

- (void)fetchFaceBookUserinfoWithCallBack:(BitchFacebookLoginBlock)loginBlock {
    NSDictionary *params = @{@"fields": @"id,email,name,picture.type(large)"};
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                                   parameters:params
                                                                   HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection * _Nullable connection, id  _Nullable result, NSError * _Nullable error) {
        if (error) {
            loginBlock(nil, error);
        } else {
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resultNew = (NSDictionary *)result;
                NSString *userId = [resultNew objectForKey:@"id"];
                NSString *fullName = [resultNew objectForKey:@"name"];
                NSString *email = [resultNew objectForKey:@"email"];
                NSString *picUrl = @"";
                
                if ([resultNew objectForKey:@"picture"] && [[resultNew objectForKey:@"picture"] objectForKey:@"data"] && [[[resultNew objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]) {
                    picUrl = [[[resultNew objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
                }
                
                NSDictionary *userInfo = @{@"uid" : userId ? : @"",
                                           @"name" : fullName ? : @"",
                                           @"email" : email ? : @"",
                                           @"picUrl": picUrl
                };
                loginBlock(userInfo, nil);
            } else {
                loginBlock(nil, [NSError errorWithDomain:@"facebookLogin" code:BitchLoginResultSystemError userInfo:@{NSLocalizedDescriptionKey : @"ErrorInvalidResponse"}]);
            }
        }
    }];
}

#pragma mark - ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]])       {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        NSString *userId = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        
        if (userId && userId.length > 0) {
            NSDictionary *userInfo = @{@"uid" : userId,
                                       @"name" : fullName.nickname ? : @"",
                                       @"email" : email ? : @""};
            self.appleLoginBlock(userInfo, nil);
        } else {
            self.appleLoginBlock(nil, [NSError errorWithDomain:@"AppleLogin" code:BitchLoginResultSystemError userInfo:@{NSLocalizedDescriptionKey : @"ErrorInvalidResponse"}]);
        }
    } else {
        self.appleLoginBlock(nil, [NSError errorWithDomain:@"AppleLogin" code:BitchLoginResultSystemError userInfo:@{NSLocalizedDescriptionKey : @"ErrorInvalidResponse"}]);
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    self.appleLoginBlock(nil, error);
}

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return [BitchApplication presentingVc].view.window;
}

@end
