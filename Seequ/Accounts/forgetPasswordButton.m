//
//  forgetPasswordButton.m
//  Seequ
//
//  Created by peng wan on 15-2-7.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "forgetPasswordButton.h"
#import "RingStyleKit.h"

@interface forgetPasswordButton ()
@property (assign, nonatomic) BOOL isPressed;
@end

@implementation forgetPasswordButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.isPressed) {
        [RingStyleKit drawLogin_create_forgot_password_buttonWithPressed:YES];
    } else
        [RingStyleKit drawLogin_create_forgot_password_buttonWithPressed:NO];
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
