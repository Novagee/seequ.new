
@import UIKit;
@import Foundation;


/*
 A generic contact class used to represent both Address Book and Seequ contacts
*/


typedef NS_ENUM(NSUInteger, RingGenericContactError) {
    RingGenericContactErrorBadArgument = 1
};


@interface RingGenericContact : NSObject

+ (instancetype)genericContactWithFirstName:(NSString *)firstName
                                   lastName:(NSString *)lastName
                               emailAddress:(NSString *)email
                          andThumbnailImage:(UIImage *)thumbnailImage
                                      error:(NSError **)error;

@property (nonatomic, strong, readonly) NSString *firstName;
@property (nonatomic, strong, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) UIImage *thumbnailImage;
@property (nonatomic, strong, readonly) NSString *fullName;

- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;
- (NSComparisonResult)compare:(RingGenericContact *)otherContact;

@end
