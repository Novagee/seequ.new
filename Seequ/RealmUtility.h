//
//  RealmUtility.h
//  Seequ
//
//  Created by Paul on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

#import "Folder.h"
#import "Bookmark.h"

@interface RealmUtility : NSObject

+ (int)validIndexFrom:(Class)realmModelClass ;

+ (void)insertObject:(RLMObject *)object;
+ (void)deleteObject:(RLMObject *)object;

@end
