//
//  RealmUtility.m
//  Seequ
//
//  Created by Peng Wan on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RealmUtility.h"

@implementation RealmUtility

+ (int)validIndexFrom:(Class)realmModelClass {
    
    RLMResults *result = [realmModelClass allObjects];
    NSNumber *maxIndex = [result maxOfProperty:@"_id"];
    int _id = [maxIndex intValue] + 1;
    
    return _id;
}

+ (void)insertObject:(RLMObject *)object {
    
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

@end
