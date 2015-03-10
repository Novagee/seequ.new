
#import "RingGenericContact.h"
#import "RingUtility.h"


@interface RingGenericContact ()

@property (nonatomic, strong, readwrite) NSString *firstName;
@property (nonatomic, strong, readwrite) NSString *lastName;
@property (nonatomic, strong, readwrite) NSString *email;
@property (nonatomic, strong, readwrite) UIImage *thumbnailImage;

@end


@implementation RingGenericContact

+ (instancetype)genericContactWithFirstName:(NSString *)firstName
                                   lastName:(NSString *)lastName
                               emailAddress:(NSString *)email
                          andThumbnailImage:(UIImage *)thumbnailImage
                                      error:(NSError **)error {
    
    RingGenericContact *contact = [[RingGenericContact alloc] init];
    
    contact.firstName = firstName;
    contact.lastName = lastName;
    contact.thumbnailImage = thumbnailImage;
    
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
