//
//  RingActivityManager.h
//  Seequ
//
//  Created by peng wan on 15-3-9.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingNetworkingManager.h"

@interface RingActivityNetworkingManager : RingNetworkingManager

+(instancetype)sharedInstance;

-(void) getActivityListWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void) getActivityWithID:(NSString *)activityID success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;

@end
