//
//  ActivityCell.h
//  Seequ
//
//  Created by Peng Wan on 3/5/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *callerName;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
