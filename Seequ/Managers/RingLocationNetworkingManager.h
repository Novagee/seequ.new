//
//  RingLocationNetworkingManager.h
//  Seequ
//
//  Created by Paul on 3/27/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingNetworkingManager.h"

@interface RingLocationNetworkingManager : NSObject

- (void)createLocationWithBody:(NSString *)body
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure;

- (void)deleteLocation:(NSString *)locationID
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure;

- (void)getLocationListWithSuccess:(RingNetworkingLibSuccessBlock)success
                           failure:(RingNetworkingLibFailureBlock)failure;

- (void)getLocation:(NSString *)locationID
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure;

- (void)updateLocation:(NSString *)locationID
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure;

@end
