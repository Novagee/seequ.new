//
//  Contact.h
//  Seequ
//
//  Created by Jose Correa on 10/15/14.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>
#import "Location.h"
#import "Language.h"

@interface Contact : RLMObject
@property NSString *name;
@property NSString *bio;
@property NSString *email;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *introduction;
@property BOOL isFavorite;
@property BOOL isImageExist;
@property BOOL isMute;
@property BOOL needToDoubleTake;
@property NSDate *regDate;
@property NSString *seeQuId;
@property NSString *title;
@property NSString *photoURL;
@property double billingRate;
//@property NSSet *contactInfoList;
//@property NSSet *groups;
//@property NSSet *internetInfoList;
//@property NSSet *socialInfoList;
//@property UserStatusCoreData *status;

@property Location *location;

@property Language *language;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Contact>
RLM_ARRAY_TYPE(Contact)
