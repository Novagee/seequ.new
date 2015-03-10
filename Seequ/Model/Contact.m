
#import "Contact.h"


@implementation Contact

+ (NSString *)primaryKey {
    return @"_id";
}

+ (NSArray *)indexedProperties {
    return @[@"name", @"email"];
}

- (NSArray *)users {
    return [self linkingObjectsOfClass:@"User" forProperty:@"contacts"];
}

@end
