//
//  RingConversationNetworkingManager.m
//  Seequ
//
//  Created by Paul on 3/25/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingConversationNetworkingManager.h"

@implementation RingConversationNetworkingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RingConversationNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingConversationNetworkingManager alloc] init];
    });
    
    return  instance;
}

- (void)createConversationWithBody:(NSDictionary *)body
                           success:(RingNetworkingLibSuccessBlock)success
                           failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_CONVERSATION_PATH body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)getConversationListWithSuccess:(RingNetworkingLibSuccessBlock)success
                               failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:RING_NETWORKING_LIB_CONVERSATION_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)startConversationUser:(NSString *)userID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/start", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)endConversationUser:(NSString *)userID
                    success:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/end", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)leaveConversationUser:(NSString *)userID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/leave", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)joinConversationUser:(NSString *)userID
                     success:(RingNetworkingLibSuccessBlock)success
                     failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/join", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
    
}

- (void)inviteConversationUser:(NSString *)userID
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/invite", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
}

- (void)pauseConversationUser:(NSString *)userID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure  {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/pause", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
}

- (void)resumeConversationUser:(NSString *)userID
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@/resume", RING_NETWORKING_LIB_CONVERSATION_PATH, userID] body:@{} success:^(id successResponse) {
        
        success(successResponse);
        
    } failure:^(id failureResponse, NSError *error) {
        
        failure(failureResponse, error);
        
    }];
}


@end
