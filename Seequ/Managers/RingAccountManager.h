//
//  RingAccountManager.h
//  Seequ
//
//  Created by peng wan on 15-2-9.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingAPIManager.h"

@interface RingAccountManager : RingAPIManager

+(instancetype)sharedInstance;

//Authentication
-(void)signInWithEmail:(NSString*)email password:(NSString*)password success:(Success)success failure:(Failure)failure;
-(void)signUpWithFirstName:(NSString*)firstName lastName:(NSString *)lastName email:(NSString*)email password:(NSString*)password success:(Success)success failure:(Failure)failure;
-(void)signOutWithSuccess:(Success)success failure:(Failure)failure;
-(void)resetPasswordForEmail:(NSString *)email success:(Success)success failure:(Failure)failure;

@end
