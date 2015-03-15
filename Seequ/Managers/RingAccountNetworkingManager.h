//
//  RingAccountManager.h
//  Seequ
//
//  Created by peng wan on 15-2-9.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingNetworkingManager.h"

@interface RingAccountNetworkingManager : RingNetworkingManager

+(instancetype)sharedInstance;

//Authentication
-(void)signInWithEmail:(NSString*)email password:(NSString*)password success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)signUpWithFirstName:(NSString*)firstName lastName:(NSString *)lastName email:(NSString*)email password:(NSString*)password success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)signOutWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)resetPasswordForEmail:(NSString *)email success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;

@end
