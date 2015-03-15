//
//  RingAccountManager.m
//  Seequ
//
//  Created by peng wan on 15-2-9.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingAccountNetworkingManager.h"

@implementation RingAccountNetworkingManager

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RingAccountNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingAccountNetworkingManager alloc] init];
    });
    
    return  instance;
}

-(void)signInWithEmail:(NSString*)email password:(NSString*)password success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"email": email,
                                 @"password": password,
                                 @"fields": @true
                                 };

    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_SIGNIN_PATH body:bodyObject success:^(id successResponse) {
        
        if ([successResponse isKindOfClass:[NSDictionary class]]) {            
            success(successResponse);
        } else {
            NSDictionary *detail = @{NSLocalizedDescriptionKey:@"Login - Server response is not of type dictionary"};
            NSError *error = [NSError errorWithDomain:@"InvalidArgumentErrorDomain"
                                                 code:RingAPIManagerErrorBadArgument
                                             userInfo:detail];
            failure(nil, error);
        }

    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)signUpWithFirstName:(NSString*)firstName lastName:(NSString *)lastName email:(NSString*)email password:(NSString*)password success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"name": @{@"first":firstName,@"last":lastName},
                                 @"email": email,
                                 @"password": password
                                 };

    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_SIGNUP_PATH body:bodyObject success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)signOutWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib putToPath:RING_NETWORKING_LIB_SIGNOUT_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)resetPasswordForEmail:(NSString *)email success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    
    [RingNetworkingLib putToPath:RING_NETWORKING_LIB_RESET_PASSWORD_PATH body:@{@"email":email} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}


@end
