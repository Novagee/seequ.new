//
//  Info.h
//  Seequ.Next
//
//  Created by Peng Wan on 10/18/14.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RLMObject.h"

@interface Info : RLMObject

@property NSString *name;
@property NSString *value;

@end
RLM_ARRAY_TYPE(Info)