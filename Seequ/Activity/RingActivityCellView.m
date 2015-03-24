//
//  RingActivityCellView.m
//  Seequ
//
//  Created by peng wan on 15-3-9.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingActivityCellView.h"
#import "RingStyleKit.h"

@interface RingActivityCellView ()

@property (assign, nonatomic) BOOL isPressed;

@end

@implementation RingActivityCellView


typedef NS_ENUM(NSUInteger, RingStyleKitContactStatus) {
    RingStyleKitContactStatusActive = 1,
    RingStyleKitContactStatusAway,
    RingStyleKitContactStatusBusy,
    RingStyleKitContactStatusUnkown
};



- (void)drawRect:(CGRect)rect {
    // Drawing code
    [RingStyleKit drawActivity_rowWithActivity_row_frame:CGRectMake(39.58, 5.42, 72.77, 39)
                             contact_profile_placeholder:[UIImage imageNamed:@"contact_profile_photo_placeholder"]
                                                 pressed:self.isPressed
                                           notifications:20
                                               firstName:@"Peng"
                                                lastName:@"Wan"
                                                    away:NO
                                            contactgroup:NO
                                                    busy:NO
                                                  active:YES
                                                 unknown:NO
                                                favorite:YES
                                          timestamp_text:@"04/01/15"];

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
