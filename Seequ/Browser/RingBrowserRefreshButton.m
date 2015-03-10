//
//  RingBrowserRefreshButton.m
//  Seequ
//
//  Created by peng wan on 15-3-1.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingBrowserRefreshButton.h"
#import "App_StyleKit.h"

@interface RingBrowserRefreshButton ()
@property (assign, nonatomic) BOOL isPressed;
@end
@implementation RingBrowserRefreshButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [App_StyleKit drawBrowser_url_reload_buttonWithPressed:self.isPressed];
}
     
     -(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
    {
        self.isPressed = YES;
        [self setNeedsDisplay];
        [super touchesBegan:touches withEvent:event];
    }
     
     -(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
    {
        self.isPressed = NO;
        [self setNeedsDisplay];
        [super touchesEnded:touches withEvent:event];
    }


@end
