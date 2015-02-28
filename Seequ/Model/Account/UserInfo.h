//
//  UserInfo.h
//  Seequ.Next
//
//  Created by peng wan on 14-10-18.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RLMObject.h"
#import "Location.h"
#import "Language.h"
#import "UserStatus.h"
#import "Contact.h"
#import "Info.h"

@interface UserInfo : RLMObject

@property NSString *bio;
@property NSString *email;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *introduction;
@property NSString *title;
@property NSString *groups;
@property BOOL isFavorite;
@property BOOL isImageExist;
@property BOOL isMute;
@property BOOL needToDoubleTake;
@property NSDate *regDate;
@property NSData *userImage;
@property double billingRate;
@property NSString *seeQuId;
@property RLMArray<Contact> *contactInfoList;
@property RLMArray<Info> *internetInfoList;
@property Location *location;
@property RLMArray<Contact> *socialInfoList;
@property UserStatus *status;
@property Language *userLanguage;

@end

RLM_ARRAY_TYPE(UserInfo)
