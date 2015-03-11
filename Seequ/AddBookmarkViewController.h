//
//  AddBookmarkViewController.h
//  Seequ
//
//  Created by Paul on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealmUtility.h"

@interface AddBookmarkViewController : UIViewController

@property (strong, nonatomic) Folder *rootFolder;
@property (strong, nonatomic) NSString *urlString;

@end
