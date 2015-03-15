//
//  RingActivityManager.m
//  Seequ
//
//  Created by peng wan on 15-3-9.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingActivityNetworkingManager.h"

@implementation RingActivityNetworkingManager

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RingActivityNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingActivityNetworkingManager alloc] init];
    });
    
    return  instance;
}

@end
