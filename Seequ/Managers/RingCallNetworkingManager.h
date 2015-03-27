//
//  RingCallNetworkingManager.h
//  Seequ
//
//  Created by Paul on 3/25/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingNetworkingManager.h"

@import Foundation;

@interface RingCallNetworkingManager : NSObject

+ (instancetype)sharedInstance;

- (void)createCallWithSuccess:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure;

- (void)getCallListWithSuccess:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure;

- (void)startCallUser:(NSString *)userID
              success:(RingNetworkingLibSuccessBlock)success
              failure:(RingNetworkingLibFailureBlock)failure;

- (void)endCallUser:(NSString *)userID
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure;

- (void)addCallUser:(NSString *)userID
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure;

- (void)resumeCallUser:(NSString *)userID
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure ;

- (void)pauseCallUser:(NSString *)userID
              success:(RingNetworkingLibSuccessBlock)success
              failure:(RingNetworkingLibFailureBlock)failure;

- (void)deleteCallUser:(NSString *)user
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure;



@end
