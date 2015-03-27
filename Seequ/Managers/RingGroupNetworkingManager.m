//
//  RingGroupNetworkingManager.m
//  Seequ
//
//  Created by Paul on 3/25/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingGroupNetworkingManager.h"

@implementation RingGroupNetworkingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RingGroupNetworkingManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RingGroupNetworkingManager alloc] init];
    });
    
    return  instance;
}

- (void)createRoomWithBody:(NSDictionary *)body
                   inGroup:(NSString *)groupID
                   success:(RingNetworkingLibSuccessBlock)success
                   failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/%@/add", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)addMembershipWithBody:(NSDictionary *)body
                      inGroup:(NSString *)groupID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/%@/memberships", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)addContactsWithBody:(NSDictionary *)body
                    inGroup:(NSString *)groupID
                    success:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/%@/contacts", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)broadcastWithBody:(NSDictionary *)body
                  inGroup:(NSString *)groupID
                  success:(RingNetworkingLibSuccessBlock)success
                  failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/%@/broadcast", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)checkRoomExistWithName:(NSString *)roomName
                 success:(RingNetworkingLibSuccessBlock)success
                 failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_GROUP_PATH, roomName] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)createGroupFromContactWithBody:(NSDictionary *)body
                               success:(RingNetworkingLibSuccessBlock)success
                               failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"%@/contacts", RING_NETWORKING_LIB_GROUP_PATH] body:body success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)createGroupWithSuccess:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_GROUP_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)deleteGroup:(NSString *)groupID
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib deleteToPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)getGroup:(NSString *)groupID
                    success:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)getGroupListWithSuccess:(RingNetworkingLibSuccessBlock)success
                        failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:RING_NETWORKING_LIB_GROUP_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)getGroupMembersWithGroupID:(NSString *)groupID
                           success:(RingNetworkingLibSuccessBlock)success
                           failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib getFromPath:[NSString stringWithFormat:@"%@/%@/members", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

- (void)updateGroupWithGroupID:(NSString *)groupID
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure {
    
    [RingNetworkingLib putToPath:[NSString stringWithFormat:@"%@/%@", RING_NETWORKING_LIB_GROUP_PATH, groupID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
    
}

@end
