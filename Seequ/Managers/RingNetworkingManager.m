//
//  RingNetworkManager.m
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingNetworkingManager.h"


@implementation RingNetworkingManager

- (instancetype)init {
    
    NSString *abstractClassAssertMessage =
    [NSString stringWithFormat:@"%@ is an abstract class. Please use one of its concrete subclasses", NSStringFromSelector(_cmd)];
    
    NSAssert(![self isMemberOfClass:[RingNetworkingManager class]], abstractClassAssertMessage);
    
    return [super init];
}

@end
