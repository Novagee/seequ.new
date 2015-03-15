//
//  RealmUtility.h
//  Seequ
//
//  Created by Peng Wan on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

#import "Folder.h"
#import "Bookmark.h"

#define kRootAncestorID 0
#define kRootFolderID 1
#define kHistoryFolderID 2

@interface RealmUtility : NSObject

+ (int)validIndexFrom:(Class)realmModelClass ;

+ (void)insertObject:(RLMObject *)object;
+ (void)deleteObject:(RLMObject *)object;

@end
