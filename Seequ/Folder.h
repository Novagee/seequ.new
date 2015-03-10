//
//  Folder.h
//  Seequ
//
//  Created by Paul on 3/10/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"
#import "Folder.h"
#import "Bookmark.h"

RLM_ARRAY_TYPE(Folder)
RLM_ARRAY_TYPE(Bookmark)

@interface Folder : RLMObject

@property NSString *_id;
@property NSString *name;
@property NSString *ancestorName;
@property RLMArray<Folder> *folders;
@property RLMArray<Bookmark> *bookmarks;

@end