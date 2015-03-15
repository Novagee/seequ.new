//
//  loginLogo.m
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "loginLogo.h"
#import "RingStyleKit.h"

@implementation loginLogo

- (void)drawRect:(CGRect)rect {

    [RingStyleKit drawLogin_logoWithProgressPercent:100];
}

@end
