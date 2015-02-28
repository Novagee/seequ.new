//
//  RingAccountManager.m
//  Seequ
//
//  Created by peng wan on 15-2-9.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingAccountManager.h"
#import "UserInfo.h"
#import "Contact.h"

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

- (void)loginWithSeequID:(NSString*)seequID Password:(NSString*)password success:(SignInSuccess)successBlk failure:(SignInFailure)failureBlk
{
    UserInfo *user = [[UserInfo alloc] init];
    user.firstName = @"Peng";
    user.lastName = @"Wan";
    user.bio = @"peng's biography";
    user.email = @"mrpengwan@Gmail.com";
    user.introduction = @"Seequ developer";
    user.groups = @"iOS groups";
    user.isFavorite = YES;
    user.isImageExist = NO;
    user.isMute = NO;
    user.needToDoubleTake = YES;
    user.regDate = [[NSDate alloc]init];
    user.seeQuId = @"001";
    user.title = @"Mr.";
    user.userImage = [[NSData alloc]init];
    user.billingRate = 1.0;
    successBlk(user);
}

- (void)registerWithEmail:(NSString*)email Password:(NSString*)password success:(SignInSuccess)successBlk failure:(SignInFailure)failureBlk;
{
    UserInfo *user = [[UserInfo alloc] init];
    user.firstName = @"Peng";
    user.lastName = @"Wan";
    user.bio = @"peng's biography";
    user.email = @"mrpengwan@Gmail.com";
    user.introduction = @"Seequ developer";
    user.groups = @"iOS groups";
    user.isFavorite = YES;
    user.isImageExist = NO;
    user.isMute = NO;
    user.needToDoubleTake = YES;
    user.regDate = nil;
    user.seeQuId = @"001";
    user.title = @"Mr.";
    user.regDate = [[NSDate alloc]init];
    user.userImage = [[NSData alloc]init];
    user.billingRate = 1.0;
    successBlk(user);
}

@end
