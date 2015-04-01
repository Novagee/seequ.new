//
//  BookmarkListViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "BookmarkListViewController.h"
#import "AddFolderViewController.h"
#import "Folder.h"
#import "RingRealmManager.h"
#import "RingStyleKit.h"

@interface BookmarkListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *folderList;

@property (weak, nonatomic) IBOutlet UILabel *navigationBarTitle;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *addFolderButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *navBarViewLabel;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIView *bottomNavView;

@property (nonatomic, strong) RingRealmManager *realmManager;

@end

@implementation BookmarkListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _folderList = [[NSMutableArray alloc]init];
    _navigationBarTitle.text = self.currentFolder.name;
    
    if (self.insertMode) {
        _editButton.hidden = YES;
        _addFolderButton.hidden = YES;
    }
    
    self.navBarView.backgroundColor = [RingStyleKit seequFoam];
    self.navBarViewLabel.textColor = [RingStyleKit white];
    [self.prevButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
    
    self.bottomNavView.backgroundColor = [RingStyleKit seequFoam];
    [self.editButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
    [self.addFolderButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self configureBookmarkFolderList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.folderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //BookmarkFolderCell
    RLMObject *rlmObject = self.folderList[indexPath.row];
    
    if ([rlmObject isKindOfClass:[Bookmark class]] && ! self.insertMode) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HistoryCell"
                                                                     forIndexPath:indexPath];
        cell.textLabel.text = ((Bookmark *)self.folderList[indexPath.row]).name;
        cell.detailTextLabel.text = ((Bookmark *)self.folderList[indexPath.row]).url;
        return cell;
    }
    else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Bookmark"
                                                                     forIndexPath:indexPath];
        cell.textLabel.text = ((Folder *)self.folderList[indexPath.row]).name;
        return cell;
    }
    

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        

        // Fetch the directory path for the folder which will delete
        //
        RLMObject *object = self.folderList[indexPath.row];
        [_folderList removeObject:object];
        [RingRealmManager deleteObject:object];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RLMObject *rlmObject = self.folderList[indexPath.row];
    
    if ([rlmObject isKindOfClass:[Bookmark class]] && ! self.insertMode) {
        
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
        bookmarkListViewController.insertMode = self.insertMode;
        
        [self.navigationController pushViewController:bookmarkListViewController animated:YES];
    }
    
    
}

#pragma mark - Bookmark List Stuff

- (void)configureBookmarkFolderList {
    
    [_folderList removeAllObjects];
    
    // Fetch current list
    //
    if (!self.insertMode) {
        RLMResults *bookmarks = [Bookmark objectsWhere:[NSString stringWithFormat:@"folderID = %d", self.currentFolder._id]];
        for (NSUInteger index = 0; index < bookmarks.count; index++) {
            
            Bookmark *bookmark = [bookmarks objectAtIndex:index];
            [_folderList addObject:bookmark];
            
        }
    }
    
    RLMResults *folders = [Folder objectsWhere:[NSString stringWithFormat:@"ancestorID = %d", self.currentFolder._id]];
    for (NSUInteger index = 0; index < folders.count; index++) {
        
        Folder *folder = [folders objectAtIndex:index];
        
        if (! [folder.name isEqualToString:@"History"]) {
            [_folderList addObject:folder];
        }
        
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

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)doneButtonTouchUpInside:(id)sender {
    
    if (self.insertMode) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SeeNotificationAddBookmarkFolder"
                                                           object:nil
                                                         userInfo:@{
                                                                    @"folder": self.currentFolder
                                                                        }];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (IBAction)editButtonTouchUpInside:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    BOOL switched = [button.currentTitle isEqualToString:@"Edit"];
    [self switchEditMode:switched];
    
}

- (IBAction)addFolderTouchUpInside:(id)sender {
    
    AddFolderViewController *addFolderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editFolderView"];
    addFolderViewController.currentFolder = self.currentFolder;
    
    [self.navigationController pushViewController:addFolderViewController animated:YES];
    
}

@end
