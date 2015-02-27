//
//  Language.h
//  Seequ.Next
//
//  Created by Peng Wan on 10/17/14.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>

@interface Language : RLMObject

@property NSString *primaryLanguage;
@property NSString *secondLanguage;
@property NSString *thirdLanguage;
@property NSString *fourthLanguage;

@end

//RLM_ARRAY_TYPE(Language)
