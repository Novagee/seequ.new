//
//  RingGenericContact.m
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingGenericContact.h"
#import "RingUtility.h"


@interface RingGenericContact ()

@property (nonatomic, strong, readwrite) NSString *firstName;
@property (nonatomic, strong, readwrite) NSString *lastName;
@property (nonatomic, strong, readwrite) NSString *email;
@property (nonatomic, strong, readwrite) NSString *company;
@property (nonatomic, strong, readwrite) NSString *jobTitle;
@property (nonatomic, strong, readwrite) UIImage *thumbnailImage;
@property (nonatomic, readwrite) RingGenericContactType type;
@property (nonatomic, readwrite) BOOL favorite;

@end


@implementation RingGenericContact

+ (instancetype)genericContactWithType:(RingGenericContactType)type
                          andFirstName:(NSString *)firstName
                              lastName:(NSString *)lastName
                        andCompanyName:(NSString *)company
                           andJobTitle:(NSString *)jobTitle
                          emailAddress:(NSString *)email
                     andThumbnailImage:(UIImage *)thumbnailImage
                              favorite:(BOOL)favorite
                 numberOfNotifications:(NSUInteger)numberOfNotifications
                                 error:(NSError **)error {
    
    RingGenericContact *contact = [[RingGenericContact alloc] init];
    
    contact.type = type;
    contact.firstName = firstName;
    contact.lastName = lastName;
    contact.company = company;
    contact.jobTitle = jobTitle;
    contact.thumbnailImage = thumbnailImage;
    contact.favorite = favorite;
    contact.numberOfNotifications = numberOfNotifications;
    
    if ([RingUtility isValidEmail:email]) {
        contact.email = email;
        return contact;
    } else {
        NSDictionary *errorDetail = @{NSLocalizedDescriptionKey:@"Invalid E-mail Address"};
        *error = [NSError errorWithDomain:@"InvalidArgumentErrorDomain"
                                     code:RingGenericContactErrorBadArgument
                                 userInfo:errorDetail];
        return nil;
    }
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

#pragma mark - isEqual, Hash & Compare

- (BOOL)isEqual:(id)object {
    
    if (self == object) return YES;
    if ([self class] != [object class]) return NO;
    
    RingGenericContact *contact = (RingGenericContact *)object;
    return [self.email isEqualToString:contact.email];
}

- (NSUInteger)hash {
    return [self.email hash];
}

- (NSComparisonResult)compare:(RingGenericContact *)otherContact {
    return [self.fullName compare:otherContact.fullName options:NSCaseInsensitiveSearch];
}

@end
