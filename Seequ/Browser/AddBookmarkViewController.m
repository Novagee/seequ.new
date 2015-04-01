//
//  AddBookmarkViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "AddBookmarkViewController.h"
#import "BookmarkListViewController.h"
#import "Folder.h"
#import "RingRealmManager.h"
#import "RingStyleKit.h"

@interface AddBookmarkViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) RingRealmManager *realmManager;
@property (strong, nonatomic) Folder *currentFolder;
@property (weak, nonatomic) IBOutlet UITextField *bookmarkField;

@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *navBarViewLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation AddBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    // Add a observer
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAddBookmarkFolder:) name:@"SeeNotificationAddBookmarkFolder" object:nil];
    
    self.navBarView.backgroundColor = [RingStyleKit seequFoam];
    self.navBarViewLabel.textColor = [RingStyleKit white];
    [self.cancelButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SeeNotificationAddBookmarkFolder" object:nil];
    
}

- (void)changeAddBookmarkFolder:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    _currentFolder = userInfo[@"folder"];
    
    [self.tableView reloadData];
}

#pragma mark - Table View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"EditTitleCell"
                                                                          forIndexPath:indexPath];
            return cell;
        }
        else {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
            cell.textLabel.text = self.urlString;
            cell.detailTextLabel.text = [NSDate date].description;
            
            return cell;
        }
    }
    else {
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FolderCell"
                                                                     forIndexPath:indexPath];
        cell.textLabel.text = (self.currentFolder.name.length != 0? self.currentFolder.name : self.rootFolder.name);
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            BookmarkListViewController *bookmarkListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookmarkListView"];
            
            bookmarkListViewController.currentFolder = self.rootFolder;
            bookmarkListViewController.insertMode = YES;
            
            [self.navigationController pushViewController:bookmarkListViewController animated:YES];
            
        }
    }
    
}

#pragma mark - TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.text.length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Folder title should not be empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alertView show];
        
    }
    else {
        
        [textField resignFirstResponder];
        
        // Insert a folder
        //
        Bookmark *bookmark = [[Bookmark alloc]init];
        
        bookmark.name = textField.text;
        bookmark.url = self.urlString;
        bookmark._id = [RingRealmManager validIndexFrom:[Bookmark class]];
        bookmark.saveDate = [NSDate date];
        bookmark.folderID = self.currentFolder._id;
        
        // Commit the change
        //
        [RingRealmManager addObject:bookmark];
     
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    return YES;
    
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
