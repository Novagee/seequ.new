//
//  SeequLibConstant.h
//  Seequ
//
//  Created by peng wan on 15-3-8.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const BASE_URL;
extern NSString *const SIGNIN_PATH;
extern NSString *const SIGNUP_PATH;
extern NSString *const SIGNOUT_PATH;
extern NSString *const RESET_PASSWORD_PATH;
extern NSString *const GROUP_PATH;

typedef void (^Success) (id successResponse);
typedef void (^Failure) (id failureResponse, NSError *error);
