//
//  RingContactsTableViewCell.h
//  Seequ
//
//  Created by JB DeLima on 3/12/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RingContactsTableViewCell : UITableViewCell

@property (nonatomic, copy) UIImage *profileImage;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *jobTitle;
@property (nonatomic) BOOL favorite;
@property (nonatomic) NSUInteger numberOfNotifications;

@end
