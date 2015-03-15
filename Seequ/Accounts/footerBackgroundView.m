//
//  footerBackgroundView.m
//  Seequ
//
//  Created by peng wan on 15-2-7.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "footerBackgroundView.h"
#import "RingStyleKit.h"

@implementation footerBackgroundView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[RingStyleKit seequFoam] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);

}

@end
