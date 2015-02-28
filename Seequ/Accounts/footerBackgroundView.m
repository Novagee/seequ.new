//
//  footerBackgroundView.m
//  Seequ
//
//  Created by peng wan on 15-2-7.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "footerBackgroundView.h"
#import "App_StyleKit.h"

@implementation footerBackgroundView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[App_StyleKit seequFoam] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);

}

@end
