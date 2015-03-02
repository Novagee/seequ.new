//
//  RingBrowserNavBarTextfield.m
//  Seequ
//
//  Created by peng wan on 15-2-26.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingBrowserNavBarTextfield.h"
#import "App_StyleKit.h"

@implementation RingBrowserNavBarTextfield


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [App_StyleKit drawBrowser_url_field_backgroundWithFrame:rect];
}

@end
