//
//  Bookmark.h
//  Seequ
//
//  Created by Paul on 3/10/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"

@interface Bookmark : RLMObject

@property NSString *_id;
@property NSString *url;
@property NSString *name;
@property NSDate *saveData;
@property NSString *folderName;

@end
