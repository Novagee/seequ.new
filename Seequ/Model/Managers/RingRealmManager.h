//
//  RingRealmManager.h
//  Seequ
//
//  Created by JB DeLima on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface RingRealmManager : NSObject

+ (instancetype)sharedRealmManager;

- (void)createOrUpdateUserWithServerData:(NSDictionary *)serverData; //When creating a new user, we first delete all data currently in the database

@end
