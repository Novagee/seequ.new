//
//  RingRealmManager.h
//  Seequ
//
//  Created by JB DeLima on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Realm/Realm.h>


@interface RingRealmManager : NSObject

/*
All operations below use the default realm ([RLMRealm defaultRealm])
*/

+ (void)createOrUpdateUserWithServerData:(NSDictionary *)serverData; //When creating a new user, we first delete all data currently in the database

+ (void)addObject:(RLMObject *)object;
+ (void)deleteObject:(RLMObject *)object;
+ (int)validIndexFrom:(Class)realmModelClass;

@end
