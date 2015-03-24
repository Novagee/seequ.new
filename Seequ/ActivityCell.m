//
//  ActivityCell.m
//  Seequ
//
//  Created by Peng Wan on 3/5/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
    
    _avatarImageView.image = nil;

    _incomingCall.hidden = YES;
    _outgoingCall.hidden = YES;
    _comment.hidden = YES;
    
    _callerName.text = nil;
    _dateLabel.text = nil;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Cell Info

- (void)configureActivityType:(NSString *)action {
    
    if ([action isEqualToString:@""]) {
        
        _incomingCall.hidden = NO;
        
    }
    
    // Others ........
    
}

- (void)configureCell:(NSDictionary *)cellInfo {
    
    _avatarImageView.image = cellInfo[@"context"];
    _callerName.text = cellInfo[@"by"];
    _dateLabel.text = cellInfo[@"at"];
    
    [self configureActivityType:cellInfo[@"action"]];
    
}

+ (NSString *)cellIdentifier {
    
    return @"ActivityCell";
    
}

+ (CGFloat)cellHeight {
    
    return 64;
    
}

@end
