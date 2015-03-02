//
//  RingBrowserRefreshButton.m
//  Seequ
//
//  Created by peng wan on 15-3-1.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingBrowserRefreshButton.h"
#import "App_StyleKit.h"

@implementation RingBrowserRefreshButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [App_StyleKit drawBrowser_url_reload_button];
}

@end
