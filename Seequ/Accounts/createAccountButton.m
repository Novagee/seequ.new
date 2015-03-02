//
//  createAccountButton.m
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "createAccountButton.h"
#import "App_StyleKit.h"

@interface createAccountButton ()
@property (assign, nonatomic) BOOL isPressed;
@end
@implementation createAccountButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.isPressed) {
        [App_StyleKit drawRegistration_footer_create_account_buttonWithPressed:YES];
    } else
        [App_StyleKit drawRegistration_footer_create_account_buttonWithPressed:NO];
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
