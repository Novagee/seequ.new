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

#pragma mark - Operations on Single Objects

static NSString *const kUserPath = @"user";
static NSString *const kUserIDPath = @"user._id";

+ (void)createOrUpdateUserWithServerData:(NSDictionary *)serverData {
    
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

+ (void)addObject:(RLMObject *)object {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:object];
    [realm commitWriteTransaction];
}

+ (void)deleteObject:(RLMObject *)object {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:object];
    [realm commitWriteTransaction];
}

+ (int)validIndexFrom:(Class)realmModelClass {
    RLMResults *result = [realmModelClass allObjects];
    NSNumber *maxIndex = [result maxOfProperty:@"_id"];
    int _id = [maxIndex intValue] + 1;
    return _id;
}

@end
