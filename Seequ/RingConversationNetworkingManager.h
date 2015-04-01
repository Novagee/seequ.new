//
//  RingConversationNetworkingManager.h
//  Seequ
//
//  Created by Paul on 3/25/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingNetworkingManager.h"

@interface RingConversationNetworkingManager : NSObject

+ (instancetype)sharedInstance;

- (void)createConversationWithSuccess:(RingNetworkingLibSuccessBlock)success
                              failure:(RingNetworkingLibFailureBlock)failure;

- (void)getConversationListWithSuccess:(RingNetworkingLibSuccessBlock)success
                               failure:(RingNetworkingLibFailureBlock)failure;

- (void)startConversationUser:(NSString *)userID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure;

- (void)endConversationUser:(NSString *)userID
                    success:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure;

- (void)inviteConversationUser:(NSString *)userID
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure;

- (void)joinConversationUser:(NSString *)userID
                     success:(RingNetworkingLibSuccessBlock)success
                     failure:(RingNetworkingLibFailureBlock)failure;

- (void)leaveConversationUser:(NSString *)userID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure ;

- (void)pauseConversationUser:(NSString *)userID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure;

- (void)resumeConversationUser:(NSString *)userID
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure;


@end
