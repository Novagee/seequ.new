//
//  Contact.h
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RLMObject.h"
#import <Realm/Realm.h>


@interface Contact : RLMObject

@property NSString *_id;
@property NSString *name;
@property NSString *email;
@property (readonly) NSArray *users; //We should never have more than one object in this array as there should be only one User object in the database at a time (when a new user logs in, we delete all data currently in the database before creating the new User - please see createOrUpdateUserWithServerData: in RingRealmManager)

@end

RLM_ARRAY_TYPE(Contact)
