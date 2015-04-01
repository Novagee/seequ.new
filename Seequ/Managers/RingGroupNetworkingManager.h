//
//  RingGroupNetworkingManager.h
//  Seequ
//
//  Created by Paul on 3/25/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingNetworkingManager.h"

@interface RingGroupNetworkingManager : NSObject

+ (instancetype)sharedInstance;

- (void)createRoomWithBody:(NSDictionary *)body
                   inGroup:(NSString *)groupID
                   success:(RingNetworkingLibSuccessBlock)success
                   failure:(RingNetworkingLibFailureBlock)failure;

- (void)addMembershipWithBody:(NSDictionary *)body
                      inGroup:(NSString *)groupID
                      success:(RingNetworkingLibSuccessBlock)success
                      failure:(RingNetworkingLibFailureBlock)failure;

- (void)addContactsWithBody:(NSDictionary *)body
                    inGroup:(NSString *)groupID
                    success:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure;

- (void)broadcastWithBody:(NSDictionary *)body
                  inGroup:(NSString *)groupID
                  success:(RingNetworkingLibSuccessBlock)success
                  failure:(RingNetworkingLibFailureBlock)failure;

- (void)checkRoomExistWithName:(NSString *)roomName
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure;

- (void)createGroupFromContactWithBody:(NSDictionary *)body
                               success:(RingNetworkingLibSuccessBlock)success
                               failure:(RingNetworkingLibFailureBlock)failure;

- (void)createGroupWithSuccess:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure;

- (void)deleteGroup:(NSString *)groupID
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure;

- (void)getGroup:(NSString *)groupID
         success:(RingNetworkingLibSuccessBlock)success
         failure:(RingNetworkingLibFailureBlock)failure;

- (void)getGroupListWithSuccess:(RingNetworkingLibSuccessBlock)success
                        failure:(RingNetworkingLibFailureBlock)failure;

- (void)getGroupMembersWithGroupID:(NSString *)groupID
                           success:(RingNetworkingLibSuccessBlock)success
                           failure:(RingNetworkingLibFailureBlock)failure;

- (void)updateGroupWithGroupID:(NSString *)groupID
                       success:(RingNetworkingLibSuccessBlock)success
                       failure:(RingNetworkingLibFailureBlock)failure;

@end
