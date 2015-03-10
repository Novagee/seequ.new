//
//  RingBrowserButton.m
//  Seequ
//
//  Created by peng wan on 15-2-27.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingBrowserButton.h"
#import "App_StyleKit.h"

@interface RingBrowserButton ()
@property (assign, nonatomic) BOOL isPressed;
@end

@implementation RingBrowserButton

static NSInteger const reload_button_tag = 30000;
static NSInteger const cancel_button_tag = 30001;
static NSInteger const next_arrow_tag = 30002;
static NSInteger const prev_arrow_tag = 30003;
static NSInteger const browser_button_tag = 30004;
static NSInteger const share_button_tag = 30005;
static NSInteger const bookmark_button_tag = 30006;

- (void)drawRect:(CGRect)rect {
    // Drawing code
    switch (self.tag) {
        case reload_button_tag:
            [App_StyleKit drawBrowser_url_reload_buttonWithPressed:self.isPressed];
            break;
            
        case cancel_button_tag:
            [App_StyleKit drawBrowser_url_cancel_button];
            break;
            
        case next_arrow_tag:
            [App_StyleKit drawBrowser_next_arrowWithPressed:self.isPressed active:self.enabled];
            break;
            
        case prev_arrow_tag:
            [App_StyleKit drawBrowser_prev_arrowWithPressed:self.isPressed active:self.enabled];
            break;
            
        case browser_button_tag:
            [App_StyleKit drawBrowser_buddy_browser_buttonWithPressed:self.isPressed buddybrowse:YES];
            break;
            
        case share_button_tag:
            [App_StyleKit drawBrowser_share_menu_buttonWithPressed:self.isPressed];
            break;
            
        case bookmark_button_tag:
            [App_StyleKit drawBrowser_bookmark_buttonWithPressed:self.isPressed];
            break;
            
        default:
            break;
    }
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
