//
//  profileImageFrame.m
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "profileImageFrame.h"
#import "RingStyleKit.h"

@implementation profileImageFrame

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [RingStyleKit drawRegistration_profile_photo_frame];
}

@end
