//
//  loginButton.m
//  Seequ
//
//  Created by peng wan on 15-2-7.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "loginButton.h"
#import "App_StyleKit.h"

@interface loginButton ()
@property (assign, nonatomic) BOOL isPressed;
@end


@implementation loginButton


- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.isPressed) {
        [App_StyleKit drawLogin_buttonWithPressed:YES];
    } else
        [App_StyleKit drawLogin_buttonWithPressed:NO];
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
