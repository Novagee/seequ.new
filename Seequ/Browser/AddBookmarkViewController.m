//
//  AddBookmarkViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/11/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "AddBookmarkViewController.h"
#import "BookmarkListViewController.h"

@interface AddBookmarkViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) Folder *currentFolder;

@property (weak, nonatomic) IBOutlet UITextField *bookmarkTextField;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *folderButton;

@end

@implementation AddBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // Add a observer
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAddBookmarkFolder:) name:@"SeeNotificationAddBookmarkFolder" object:nil];
    
    [self configureBasicInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SeeNotificationAddBookmarkFolder" object:nil];
    
}

- (void)configureBasicInfo {
    
    _urlLabel.text = self.urlString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
    _dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    [_folderButton setTitle:@"Bookmark"
                   forState:UIControlStateNormal];
    _folderButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_bookmarkTextField becomeFirstResponder];
}

- (void)changeAddBookmarkFolder:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    _currentFolder = userInfo[@"folder"];
    
    [_folderButton setTitle:self.currentFolder.name
                   forState:UIControlStateNormal];
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
        [self insertBookmarkWithTitle:textField.text];
        
        [textField resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    return YES;
    
}

- (void)insertBookmarkWithTitle:(NSString *)bookmarkTitle {
    
    Bookmark *bookmark = [[Bookmark alloc]init];
    
    bookmark.name = bookmarkTitle;
    bookmark.url = self.urlString;
    bookmark._id = [RealmUtility validIndexFrom:[Bookmark class]];
    bookmark.saveDate = [NSDate date];
    bookmark.folderID = self.currentFolder._id;
    
    // Commit the change
    //
    [RealmUtility insertObject:bookmark];

}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)addButtonTouchUpInside:(id)sender {
    
    [self insertBookmarkWithTitle:self.bookmarkTextField.text];
    
}

- (IBAction)folderButtonTouchUpInside:(id)sender {

    BookmarkListViewController *bookmarkListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookmarkListView"];
    
    bookmarkListViewController.currentFolder = self.rootFolder;
    bookmarkListViewController.insertMode = YES;
    
    [self.navigationController pushViewController:bookmarkListViewController animated:YES];
    
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
