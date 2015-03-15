//
//  RingNetworkManager.h
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


@import Foundation;
#import "RingNetworkingLib.h"


/*
 This is an abstract class. Please use one of its concrete subclasses 
(e.g. RingAccountNetworkingManager, RingContactNetworkingManager, etc.) 
*/


typedef NS_ENUM(NSUInteger, RingAPIManagerError) {
    RingAPIManagerErrorBadArgument = 1
};


@interface RingNetworkingManager : NSObject

@end
