//
//  RingLocationNetworkingManager.m
//  Seequ
//
//  Created by Paul on 3/27/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingLocationNetworkingManager.h"

@implementation RingLocationNetworkingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RingLocationNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingLocationNetworkingManager alloc] init];
    });
    
    return  instance;
}

- (void)createLocationWithBody:(NSDictionary *)body
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_LOCATION_PATH body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)deleteLocation:(NSString *)locationID
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib deleteToPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_LOCATION_PATH, locationID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)getLocationListWithSuccess:(RingNetworkingLibSuccessBlock)success
                           failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:RING_NETWORKING_LIB_LOCATION_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)getLocation:(NSString *)locationID
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_LOCATION_PATH, locationID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)updateLocation:(NSString *)locationID
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_LOCATION_PATH, locationID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

@end
