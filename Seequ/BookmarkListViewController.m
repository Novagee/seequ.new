//
//  BookmarkListViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "BookmarkListViewController.h"
#import "AddFolderViewController.h"

@interface BookmarkListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *bookmarkFolders;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *addFolderButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation BookmarkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bookmarkFolders = [[NSMutableArray alloc]init];
    
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
    
    return self.bookmarkFolders.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FolderCell"
                                                                 forIndexPath:indexPath];
    cell.textLabel.text = self.bookmarkFolders[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        

        // Fetch the directory path for the folder which will delete
        //
        NSString *folderName = self.bookmarkFolders[indexPath.row];
        NSString *folderDirectoryPath = [self.currentBookmarkDirectoryPath stringByAppendingPathComponent:folderName];
        
        if ([[NSFileManager defaultManager]removeItemAtPath:folderDirectoryPath error:nil]) {
            
            [_bookmarkFolders removeObjectAtIndex:indexPath.row];
            
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookmarkListViewController *bookmarkListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookmarkListView"];
    
    NSString *folderName = self.bookmarkFolders[indexPath.row];
    NSString *bookmarkDirectoryPath = [self.currentBookmarkDirectoryPath stringByAppendingPathComponent:folderName];
    bookmarkListViewController.currentBookmarkDirectoryPath = bookmarkDirectoryPath;
    
    [self.navigationController pushViewController:bookmarkListViewController animated:YES];
    
}

#pragma mark - Bookmark List Stuff

- (void)configureBookmarkFolderList {
    
    [_bookmarkFolders removeAllObjects];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *currentBookmarkFolders = [fileManager subpathsOfDirectoryAtPath:self.currentBookmarkDirectoryPath error:nil];
    for (NSString *folder in currentBookmarkFolders) {
        
        if ([folder componentsSeparatedByString:@"/"].count == 1) {
            
            [_bookmarkFolders addObject:folder];
            
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)editButtonTouchUpInside:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    BOOL switched = [button.currentTitle isEqualToString:@"Edit"];
    [self switchEditMode:switched];
    
}

- (IBAction)addFolderTouchUpInside:(id)sender {
    
    AddFolderViewController *addFolderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editFolderView"];
    

    
    [self.navigationController pushViewController:addFolderViewController animated:YES];
    
}

@end
