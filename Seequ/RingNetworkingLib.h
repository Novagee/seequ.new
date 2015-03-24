//
//  Seequ_Lib.h
//  Seequ.Lib
//
//  Created by Jose Correa on 3/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RingNetworkingLibConstants.h"

@interface RingNetworkingLib : NSObject

+(void)postToPath:(NSString*)path
             body:(NSDictionary*)body
          success:(RingNetworkingLibSuccessBlock)success
          failure:(RingNetworkingLibFailureBlock)failure;

+(void)getFromPath:(NSString*)path
              body:(NSDictionary*)body
           success:(RingNetworkingLibSuccessBlock)success
           failure:(RingNetworkingLibFailureBlock)failure;

+(void)putToPath:(NSString*)path
            body:(NSDictionary*)body
         success:(RingNetworkingLibSuccessBlock)success
         failure:(RingNetworkingLibFailureBlock)failure;

+(void)deleteToPath:(NSString*)path
               body:(NSDictionary*)body
            success:(RingNetworkingLibSuccessBlock)success
            failure:(RingNetworkingLibFailureBlock)failure;

@end
