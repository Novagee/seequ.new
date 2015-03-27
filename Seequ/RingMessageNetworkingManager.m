//
//  RingMessageNetworkingManager.m
//  Seequ
//
//  Created by Paul on 3/27/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingMessageNetworkingManager.h"

@implementation RingMessageNetworkingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RingMessageNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingMessageNetworkingManager alloc] init];
    });
    
    return  instance;
}

- (void)appendItemInMessage:(NSString *)messageID
                     success:(RingNetworkingLibSuccessBlock)success
                     failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/%@/append", RING_NETWORKING_LIB_MESSAGE_PATH, messageID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)createMessageWithSuccess:(RingNetworkingLibSuccessBlock)success
                         failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_MESSAGE_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)deleteMessageItem:(NSString *)itemID
                inMessage:(NSString *)messageID
                  success:(RingNetworkingLibSuccessBlock)success
                  failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib deleteToPath:[NSString stringWithFormat:@"%@/%@/items/%@", RING_NETWORKING_LIB_MESSAGE_PATH, messageID, itemID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)prependItemInMessage:(NSString *)messageID
                     success:(RingNetworkingLibSuccessBlock)success
                     failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/%@/prepend", RING_NETWORKING_LIB_MESSAGE_PATH, messageID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)updateMessage:(NSString *)messageID
               success:(RingNetworkingLibSuccessBlock)success
               failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_MESSAGE_PATH, messageID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

@end
