//
//  User.h
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RLMObject.h"
#import <Realm/Realm.h>
#import "Contact.h"


@interface User : RLMObject

@property NSString *_id;
@property NSString *name;
@property NSString *email;
@property RLMArray<Contact> *contacts;

@end
