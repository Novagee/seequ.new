//
//  Contact.m
//  Seequ
//
//  Created by Jose Correa on 10/15/14.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "Contact.h"

@implementation Contact

// Specify default values for properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{
        @"bio": @"",
        @"email": @"",
        @"firstName": @"",
        @"lastName": @"",
        @"introduction": @"",
        @"isFavorite": [NSNumber numberWithBool:NO],
        @"isImageExist": [NSNumber numberWithBool:NO],
        @"isMute": [NSNumber numberWithBool:NO],
        @"needToDoubleTake": [NSNumber numberWithBool:NO],
        @"seeQuId": @"",
        @"title": @"",
        @"photoURL": @"",
        @"billingRate": [NSNumber numberWithDouble:0.0]
    };
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
