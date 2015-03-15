//
//  Bookmark.h
//  Seequ
//
//  Created by Peng Wan on 3/10/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"

@interface Bookmark : RLMObject

@property int _id;
@property int folderID;

@property NSString *url;
@property NSString *name;
@property NSDate *saveDate;

@end
