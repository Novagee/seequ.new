//
//  RingGenericContact.h
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


@import UIKit;
@import Foundation;


/*
 A generic contact class used to represent both Address Book and Seequ contacts
*/


typedef NS_ENUM(NSUInteger, RingGenericContactType) {
    RingGenericContactTypeAddressBook = 1,
    RingGenericContactTypeSeequ
};

typedef NS_ENUM(NSUInteger, RingGenericContactError) {
    RingGenericContactErrorBadArgument = 1
};


@interface RingGenericContact : NSObject

+ (instancetype)genericContactWithType:(RingGenericContactType)type
                          andFirstName:(NSString *)firstName
                              lastName:(NSString *)lastName
                        andCompanyName:(NSString *)company
                           andJobTitle:(NSString *)jobTitle
                          emailAddress:(NSString *)email
                     andThumbnailImage:(UIImage *)thumbnailImage
                              favorite:(BOOL)favorite
                 numberOfNotifications:(NSUInteger)numberOfNotifications
                                 error:(NSError **)error;

@property (nonatomic, strong, readonly) NSString *firstName;
@property (nonatomic, strong, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *fullName;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *company;
@property (nonatomic, strong, readonly) NSString *jobTitle;
@property (nonatomic, strong, readonly) UIImage *thumbnailImage;
@property (nonatomic, readonly) RingGenericContactType type;
@property (nonatomic, readonly, getter=isFavorite) BOOL favorite;
@property (nonatomic, readwrite) NSUInteger numberOfNotifications;


- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;
- (NSComparisonResult)compare:(RingGenericContact *)otherContact;

@end
