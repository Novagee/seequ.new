//
//  RingTextField.m
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingTextField.h"
#import "App_StyleKit.h"

@implementation RingTextField

// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [App_StyleKit drawResizable_text_field_backgroundWithFrame:rect error:self.isError];
}

@end
