//
//  BookmarkViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/2/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RealmUtility.h"

#import "BookmarkViewController.h"
#import "BookmarkListViewController.h"
#import "AddFolderViewController.h"
#import "HistoryViewController.h"

@interface BookmarkViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *folderList;
@property (strong, nonatomic) Folder *rootFolder;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *addFolderButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@end

@implementation BookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Configure root folder
    //
    [self configureFolderSetting];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self configureBookmarkFolderList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureFolderSetting {

    // Fetch the root folder
    //
    _rootFolder = [Folder objectsWhere:@"ancestorID = 0"].lastObject;
    
    // Init the list
    //
    _folderList = [[NSMutableArray alloc]init];
    
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 + self.folderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.row == 0) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Bookmark"
                                                                     forIndexPath:indexPath];
        cell.textLabel.text = @"History";
        return cell;
    }
    else {
        RLMObject *rlmObject = self.folderList[indexPath.row - 1];
        
        if ([rlmObject isKindOfClass:[Bookmark class]]) {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HistoryCell"
                                                                         forIndexPath:indexPath];
            cell.textLabel.text = ((Bookmark *)self.folderList[indexPath.row - 1]).name;
            cell.detailTextLabel.text = ((Bookmark *)self.folderList[indexPath.row - 1]).url;
            return cell;
        }
        else {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Bookmark"
                                                                         forIndexPath:indexPath];
            cell.textLabel.text = ((Folder *)self.folderList[indexPath.row - 1]).name;
            return cell;
        }
    }

    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        RLMObject *object = self.folderList[indexPath.row - 1];
        [self.folderList removeObject:object];
        [RealmUtility deleteObject:object];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (! tableView.editing) {
        
        if (indexPath.row == 0) {
            
            HistoryViewController *historyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"historyView"];
            [self.navigationController pushViewController:historyViewController animated:YES];
            
        }
        else {
            
            RLMObject *rlmObject = self.folderList[indexPath.row - 1];
            
            if ([rlmObject isKindOfClass:[Bookmark class]]) {
                
                NSString *urlString = ((Bookmark *)rlmObject).url;
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"SeeNotificationLoadURL"
                                                                   object:nil
                                                                 userInfo:@{
                                                                            @"url": urlString
                                                                            }];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                BookmarkListViewController *bookmarkListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookmarkListView"];
                
                bookmarkListViewController.currentFolder = (Folder *)rlmObject;
                
                [self.navigationController pushViewController:bookmarkListViewController animated:YES];
            }
            
        }
    }
    
}

#pragma mark - Bookmark List Stuff

- (void)configureBookmarkFolderList {
    
    [_folderList removeAllObjects];
    
    // Fetch current list
    //
    RLMResults *bookmarks = [Bookmark objectsWhere:[NSString stringWithFormat:@"folderID = %d", self.rootFolder._id]];
    
    for (NSUInteger index = 0; index < bookmarks.count; index++) {
        
        Bookmark *bookmark = [bookmarks objectAtIndex:index];
        [_folderList addObject:bookmark];
        
        NSLog(@"Bookmark primary key: %d", bookmark._id);
    }
    
    RLMResults *folders = [Folder objectsWhere:[NSString stringWithFormat:@"ancestorID = %d", self.rootFolder._id]];
    for (NSUInteger index = 0; index < folders.count; index++) {
        
        Folder *folder = [folders objectAtIndex:index];
        
        if (! [folder.name isEqualToString:@"History"]) {
            [_folderList addObject:folder];    
        }
        
        NSLog(@"Folder primary key: %d", folder._id);
    }
    
    [self.tableView reloadData];
    
}

- (void)switchEditMode:(BOOL)finished {
    
    _doneButton.hidden = finished;
    _addFolderButton.hidden = !finished;

    // Switch to the edit mode
    //
    [_tableView setEditing:finished animated:YES];
    [_editButton setTitle:finished? @"Done": @"Edit"
                 forState:UIControlStateNormal];
    
}

#pragma mark - Control's Action

- (IBAction)doneButtonTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)editButtonTouchUpInside:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    BOOL switched = [button.currentTitle isEqualToString:@"Edit"];
    [self switchEditMode:switched];
    
}

- (IBAction)addFolderTouchUpInside:(id)sender {
    
    AddFolderViewController *addFolderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editFolderView"];
    addFolderViewController.currentFolder = self.rootFolder;
    
    [self.navigationController pushViewController:addFolderViewController animated:YES];
}

@end
