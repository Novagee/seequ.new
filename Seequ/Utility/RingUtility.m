//
//  RingUtility.m
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingUtility.h"
#import "App_StyleKit.h"
@implementation RingUtility

+(void)setupStatusBarForView:(UIView *)superView
{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [RingUtility screenSize].width, 22)];
    statusBarView.backgroundColor = [App_StyleKit seequFoam];
    [superView addSubview:statusBarView];
}

+(CGSize) screenSize
{
    return [UIScreen mainScreen].bounds.size;
}



@end
