//
//  RingAccountManager.h
//  Seequ
//
//  Created by peng wan on 15-2-9.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SignInSuccess) (id successResponse);
typedef void (^SignInFailure) (id failureResponse, NSError *error);

@interface RingAccountManager : NSObject

+(instancetype)sharedInstance;

- (void)loginWithSeequID:(NSString*)seequID Password:(NSString*)password success:(SignInSuccess)successBlk failure:(SignInFailure)failureBlk;

- (void)registerWithEmail:(NSString*)email Password:(NSString*)password success:(SignInSuccess)successBlk failure:(SignInFailure)failureBlk;

@end
