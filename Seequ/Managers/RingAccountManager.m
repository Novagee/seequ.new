//
//  RingAccountManager.m
//  Seequ
//
//  Created by peng wan on 15-2-9.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingAccountManager.h"
#import "User.h"

@implementation RingAccountManager

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RingAccountManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingAccountManager alloc] init];
    });
    
    return  instance;
}

-(void)signInWithEmail:(NSString*)email password:(NSString*)password success:(Success)success failure:(Failure)failure
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"email": email,
                                 @"password": password,
                                 @"fields": @true
                                 };

    [SeequLib postToPath:SIGNIN_PATH body:bodyObject success:^(id successResponse) {
        
        if ([successResponse isKindOfClass:[NSDictionary class]]) {
            
            //Update local database
            RLMRealm *realm = [RLMRealm defaultRealm];
            User *currentUser = [[User allObjects] firstObject];
            if (currentUser && ![successResponse[@"user"][@"_id"] isEqualToString:currentUser._id]) {
                [realm beginWriteTransaction];
                [realm deleteAllObjects];
                [User createOrUpdateInDefaultRealmWithObject:successResponse[@"user"]];
                [realm commitWriteTransaction];
            } else {
                [realm beginWriteTransaction];
                [User createOrUpdateInDefaultRealmWithObject:successResponse[@"user"]];
                [realm commitWriteTransaction];
            }
            NSLog(@"@User in Realm: %@", [User allObjects]);
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *token = successResponse[@"token"];
            [userDefaults setObject:token forKey:@"SeequUserToken"];
            
            success(successResponse[@"user"]);
            
        } else {
            NSDictionary *errorDetail = @{NSLocalizedDescriptionKey:@"Login - Server response is not of type dictionary"};
            NSError *error = [NSError errorWithDomain:@"InvalidArgumentErrorDomain"
                                                 code:RingAPIManagerErrorBadArgument
                                             userInfo:errorDetail];
            failure(nil, error);
        }

    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
    }];
}

-(void)signUpWithFirstName:(NSString*)firstName lastName:(NSString *)lastName email:(NSString*)email password:(NSString*)password success:(Success)success failure:(Failure)failure
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"name": @{@"first":firstName,@"last":lastName},
                                 @"email": email,
                                 @"password": password
                                 };

    [SeequLib postToPath:SIGNUP_PATH body:bodyObject success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)signOutWithSuccess:(Success)success failure:(Failure)failure
{
    [SeequLib putToPath:SIGNOUT_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)resetPasswordForEmail:(NSString *)email success:(Success)success failure:(Failure)failure
{
    
    [SeequLib putToPath:RESET_PASSWORD_PATH body:@{@"email":email} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}


@end
