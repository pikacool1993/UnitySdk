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
#import <MJExtension/MJExtension.h>

@interface BitchLogin () <ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate>

@property (nonatomic, copy) BitchLoginBlock appleLoginBlock;

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

- (void)loginWithApple:(BitchLoginBlock)loginBlock API_AVAILABLE(ios(13.0)) {
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

- (void)loginWithFacebook:(BitchLoginBlock)loginBlock {
    FBSDKAccessToken *facebookToken = [FBSDKAccessToken currentAccessToken];
    if (facebookToken.tokenString && [facebookToken.expirationDate compare:[NSDate date]] != NSOrderedAscending) {
        [self fetchFaceBookUserinfoWithBlock:loginBlock];
        return;
    }
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithPermissions:@[@"public_profile", @"email"] fromViewController:[BitchApplication presentingVc] handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            loginBlock(nil, error.code, error.description);
        } else {
            if (result.isCancelled) {
                loginBlock(nil, BitchLoginResultUserCancel, @"ErrorCanceled");
            } else {
                [self fetchFaceBookUserinfoWithBlock:loginBlock];
            }
        }
    }];
}

- (void)fetchFaceBookUserinfoWithBlock:(BitchLoginBlock)loginBlock {
    NSDictionary *params = @{@"fields": @"id,email,name,picture.type(large)"};
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                                   parameters:params
                                                                   HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection * _Nullable connection, id  _Nullable result, NSError * _Nullable error) {
        if (error) {
            loginBlock(nil, error.code, error.description);
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
                                           @"picUrl": picUrl};
                NSString *userInfoJson = [userInfo mj_JSONString];
                loginBlock(userInfoJson, 0, nil);
            } else {
                loginBlock(nil, BitchLoginResultSystemError, @"ErrorInvalidResponse");
            }
        }
    }];
}

#pragma mark - ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]])       {
        ASAuthorizationAppleIDCredential *credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        
        NSString *userId = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        
        if (userId && userId.length > 0) {
            NSDictionary *userInfo = @{@"uid" : userId,
                                       @"name" : fullName.nickname ? : @"",
                                       @"email" : email ? : @""};
            NSString *userInfoJson = [userInfo mj_JSONString];
            self.appleLoginBlock(userInfoJson, 0, nil);
        } else {
            self.appleLoginBlock(nil, BitchLoginResultSystemError, @"ErrorInvalidResponse");
        }
    } else {
        self.appleLoginBlock(nil, BitchLoginResultSystemError, @"ErrorInvalidResponse");
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    self.appleLoginBlock(nil, error.code, error.description);
}

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return [BitchApplication presentingVc].view.window;
}

@end
