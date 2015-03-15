//
//  RingRealmManager.m
//  Seequ
//
//  Created by JB DeLima on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingRealmManager.h"
#import "User.h"


@implementation RingRealmManager

+ (instancetype)sharedRealmManager {
    
    static dispatch_once_t onceToken;
    static RingRealmManager *sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [[RingRealmManager alloc] init];
    });
    
    return sharedManager;
}


static NSString *const kUserPath = @"user";
static NSString *const kUserIDPath = @"user._id";

- (void)createOrUpdateUserWithServerData:(NSDictionary *)serverData {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    User *currentUser = [[User allObjects] firstObject];
    if (currentUser && ![[serverData valueForKeyPath:kUserIDPath] isEqualToString:currentUser._id]) {
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [User createOrUpdateInDefaultRealmWithObject:[serverData valueForKeyPath:kUserPath]];
        [realm commitWriteTransaction];
    } else {
        [realm beginWriteTransaction];
        [User createOrUpdateInDefaultRealmWithObject:[serverData valueForKeyPath:kUserPath]];
        [realm commitWriteTransaction];
    }
    NSLog(@"@Users in Realm: %@", [User allObjects]);
}

@end
