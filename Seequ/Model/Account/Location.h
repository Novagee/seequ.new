//
//  Location.h
//  Seequ.Next
//
//  Created by Peng Wan on 10/17/14.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>

@interface Location : RLMObject

@property NSString *country;
@property NSInteger countryId;
@property NSString *state;
@property NSString *stateAbbrev;
@property NSInteger stateId;
@property NSString *city;
@property NSString *timeZone;

@end

//RLM_ARRAY_TYPE(Location)
