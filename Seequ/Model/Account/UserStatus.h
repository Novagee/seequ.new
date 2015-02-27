//
//  UserStatus.h
//  Seequ.Next
//
//  Created by peng wan on 14-10-18.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RLMObject.h"

@interface UserStatus : RLMObject

@property NSInteger isOnline;
@property NSString *subscription;

@end

RLM_ARRAY_TYPE(UserStatus)