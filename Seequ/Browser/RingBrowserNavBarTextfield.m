//
//  RingBrowserNavBarTextfield.m
//  Seequ
//
//  Created by peng wan on 15-2-26.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingBrowserNavBarTextfield.h"
#import "RingStyleKit.h"

@implementation RingBrowserNavBarTextfield


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [RingStyleKit drawBrowser_url_field_backgroundWithFrame:rect];
}

@end
