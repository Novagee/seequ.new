//
//  Contact.h
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "Contact.h"


@implementation Contact

+ (NSString *)primaryKey {
    return @"_id";
}

+ (NSArray *)indexedProperties {
    return @[@"name", @"email"];
}

- (NSArray *)users {
    NSArray *arr = [self linkingObjectsOfClass:@"User" forProperty:@"contacts"];
    if ([arr count] > 1) {
        NSLog(@"[%@ Error] %@", [self class], @"Realm Contact is associated with more than one User");
    }
    return arr;
}

@end
