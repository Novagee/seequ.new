//
//  RingCallNetworkingManager.m
//  Seequ
//
//  Created by Paul on 3/25/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingCallNetworkingManager.h"

@implementation RingCallNetworkingManager

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken;
    static RingCallNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingCallNetworkingManager alloc] init];
    });
    
    return  instance;
}

- (void)createCallWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_CALL_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);        
    }];
    
}

- (void)getCallListWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib getFromPath:RING_NETWORKING_LIB_CALL_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)startCallUser:(NSString *)userID
              success:(RingNetworkingLibSuccessBlock)success
              failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/start", RING_NETWORKING_LIB_CALL_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)endCallUser:(NSString *)userID withSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/end", RING_NETWORKING_LIB_CALL_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)addCallUser:(NSString *)userID success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/add", RING_NETWORKING_LIB_CALL_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)resumeCallUser:(NSString *)userID success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/resume", RING_NETWORKING_LIB_CALL_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
}

- (void)pauseCallUser:(NSString *)userID success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/pause", RING_NETWORKING_LIB_CALL_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
}

- (void)deleteCallUser:(NSString *)user success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure {

    [RingNetworkingLib deleteToPath:[NSString stringWithFormat:@"%@/%@/", RING_NETWORKING_LIB_CALL_PATH, user] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
    
}

@end
