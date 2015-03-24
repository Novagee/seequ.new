//
//  RingActivityManager.m
//  Seequ
//
//  Created by peng wan on 15-3-9.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingActivityNetworkingManager.h"

@implementation RingActivityNetworkingManager

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken;
    static RingActivityNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingActivityNetworkingManager alloc] init];
    });
    
    return  instance;
}

-(void) getActivityListWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib getFromPath:RING_NETWORKING_LIB_ACTIVITY_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void) getActivityWithID:(NSString *)activityID success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib getFromPath:[NSString stringWithFormat:@"%@/%@",RING_NETWORKING_LIB_ACTIVITY_PATH, activityID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

@end
