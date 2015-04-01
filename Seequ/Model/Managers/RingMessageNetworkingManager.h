//
//  RingMessageNetworkingManager.h
//  Seequ
//
//  Created by peng wan on 15-3-26.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RingNetworkingManager.h"

@interface RingMessageNetworkingManager : NSObject

- (void)appendItemInMessage:(NSString *)messageID
                    success:(RingNetworkingLibSuccessBlock)success
                    failure:(RingNetworkingLibFailureBlock)failure;

- (void)createMessageWithSuccess:(RingNetworkingLibSuccessBlock)success
                         failure:(RingNetworkingLibFailureBlock)failure;
- (void)deleteMessageItem:(NSString *)itemID
                inMessage:(NSString *)messageID
                  success:(RingNetworkingLibSuccessBlock)success
                  failure:(RingNetworkingLibFailureBlock)failure;
- (void)prependItemInMessage:(NSString *)messageID
                     success:(RingNetworkingLibSuccessBlock)success
                     failure:(RingNetworkingLibFailureBlock)failure;
- (void)updateMessage:(NSString *)messageID
              success:(RingNetworkingLibSuccessBlock)success
              failure:(RingNetworkingLibFailureBlock)failure;

@end
