//
//  BookmarkViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/2/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Realm/Realm.h>
#import "Folder.h"
#import "Bookmark.h"

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
    [self configureRootFolder];
    
    _folderList = [[NSMutableArray alloc]init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self configureBookmarkFolderList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRootFolder {
    
    _rootFolder = [Folder objectsWhere:@"ancestorName = '/'"].lastObject;

    if (! self.rootFolder) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];

        _rootFolder = [[Folder alloc]init];
        _rootFolder.name = @"root";
        _rootFolder.ancestorName = @"/";
        
        [realm beginWriteTransaction];
        [realm addObject:_rootFolder];
        [realm commitWriteTransaction];
        
    }
    
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 + self.folderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Bookmark"
                                                                 forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"History";
    }
    else {
        RLMObject *rlmObject = self.folderList[indexPath.row - 1];
        
        if ([rlmObject isKindOfClass:[Bookmark class]]) {
            cell.textLabel.text = ((Bookmark *)self.folderList[indexPath.row - 1]).name;
        }
        else {
            cell.textLabel.text = ((Folder *)self.folderList[indexPath.row - 1]).name;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *bookmarkDirectoryPath = [documentsDirectory stringByAppendingPathComponent:@"Bookmarks"];
        
        // Fetch the directory path for the folder which will delete
        //
        NSString *folderName = self.folderList[indexPath.row - 1];
        NSString *folderDirectoryPath = [bookmarkDirectoryPath stringByAppendingPathComponent:folderName];
        
        if ([[NSFileManager defaultManager]removeItemAtPath:folderDirectoryPath error:nil]) {
            
            [_folderList removeObjectAtIndex:indexPath.row - 1];
            
        }
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
            
            BookmarkListViewController *bookmarkListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookmarkListView"];
            
            NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            NSString *bookmarkDirectoryPath = [documentsDirectory stringByAppendingPathComponent:@"Bookmarks"];
            
            NSString *folderName = self.folderList[indexPath.row - 1];
            NSString *folderDirectoryPath = [bookmarkDirectoryPath stringByAppendingPathComponent:folderName];
            bookmarkListViewController.currentBookmarkDirectoryPath = folderDirectoryPath;
            
            [self.navigationController pushViewController:bookmarkListViewController animated:YES];
            
        }
    }
    
}

#pragma mark - Bookmark List Stuff

- (void)configureBookmarkFolderList {
    
    [_folderList removeAllObjects];
    
    // Fetch current list
    //
    RLMResults *bookmarks = [Bookmark objectsWhere:@"folderName = 'root'"];
    
    for (NSUInteger index = 0; index < bookmarks.count; index++) {
        Bookmark *bookmark = [bookmarks objectAtIndex:index];
        [_folderList addObject:bookmark];
        
        NSLog(@"Primary key: %@", bookmark._id);
    }
    
    RLMResults *folders = [Folder objectsWhere:@"ancestorName = 'root'"];
    for (NSUInteger index = 0; index < folders.count; index++) {
        Folder *folder = [folders objectAtIndex:index];

        [_folderList addObject:folder];
        NSLog(@"Primary key: %@", folder._id);
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
