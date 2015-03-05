//
//  ActivityCell.m
//  Seequ
//
//  Created by Paul on 3/5/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Cell Info

+ (NSString *)cellIdentifier {
    
    return @"ActivityCell";
    
}

+ (CGFloat)cellHeight {
    
    return 51;
    
}

@end
