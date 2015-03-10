//
//  BookmarkListViewController.h
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Folder;

@interface BookmarkListViewController : UIViewController

@property (strong, nonatomic) Folder *currentFolder;

@end
