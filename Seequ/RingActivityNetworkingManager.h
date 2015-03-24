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

-(void) getActivityListWithBody:(NSDictionary *)body success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void) getActivityWithID:(NSString *)activityID success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;

- (void)addActivityWithBody:(NSDictionary *)body success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;

- (void)deleteActivityWithID:(NSString *)activityID body:(NSDictionary *)body success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;

@end
