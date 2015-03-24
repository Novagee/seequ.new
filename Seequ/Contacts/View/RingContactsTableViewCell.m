//
//  RingContactsTableViewCell.m
//  Seequ
//
//  Created by JB DeLima on 3/12/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingContactsTableViewCell.h"
#import "RingStyleKit.h"


@interface RingContactsTableViewCell ()

@property (nonatomic) CGRect kCellFrame;

@end


@implementation RingContactsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Public API

- (void)setProfileImage:(UIImage *)profileImage {
    _profileImage = [profileImage copy];
    [self setNeedsDisplay];
}

- (void)setFirstName:(NSString *)firstName {
    _firstName = [firstName copy];
    [self setNeedsDisplay];
}

- (void)setLastName:(NSString *)lastName {
    _lastName = [lastName copy];
    [self setNeedsDisplay];
}

- (void)setCompany:(NSString *)company {
    _company = [company copy];
    [self setNeedsDisplay];
}

- (void)setJobTitle:(NSString *)jobTitle {
    _jobTitle = [jobTitle copy];
    [self setNeedsDisplay];
}

- (void)setFavorite:(BOOL)favorite {
    _favorite = favorite;
    [self setNeedsDisplay];
}

- (void)setNumberOfNotifications:(NSUInteger)numberOfNotifications {
    _numberOfNotifications = numberOfNotifications;
    [self setNeedsDisplay];
}

#pragma mark - Draw Rect

- (void)drawRect:(CGRect)rect {
    
    if (CGRectIsEmpty(self.kCellFrame)) {
        self.kCellFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    
    [RingStyleKit drawContact_rowWithContact_row_frame:self.kCellFrame
                           contact_profile_placeholder:self.profileImage
                                         notifications:self.numberOfNotifications
                                             firstName:self.firstName
                                              lastName:self.lastName
                                                 title:self.jobTitle
                                               company:self.company
                                                  away:NO
                                          contactgroup:NO
                                                  busy:NO
                                                active:NO
                                               unknown:YES
                                              favorite:self.favorite];
}

@end
