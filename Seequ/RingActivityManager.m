//
//  RingActivityManager.m
//  Seequ
//
//  Created by peng wan on 15-3-9.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingActivityManager.h"

@implementation RingActivityManager

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RingActivityManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingActivityManager alloc] init];
    });
    
    return  instance;
}

@end
