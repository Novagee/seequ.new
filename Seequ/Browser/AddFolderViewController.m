
//  AddFolderViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RealmUtility.h"
#import "AddFolderViewController.h"

@interface AddFolderViewController ()< UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *folderTextField;
@end

@implementation AddFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_folderTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.text.length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Folder title should not be empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alertView show];
        
    }
    else {
        
        [textField resignFirstResponder];
        
        // Insert a folder
        //
        [self insertFolderWith:textField.text];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    return YES;
}

- (void)insertFolderWith:(NSString *)folderTitle {
    
    Folder *folder = [[Folder alloc]init];
    
    folder._id = [RealmUtility validIndexFrom:[Folder class]];
    folder.name = folderTitle;
    folder.ancestorName = self.currentFolder.name;
    folder.ancestorID = self.currentFolder._id;
    folder.saveDate = [NSDate date];
    
    // Commit the change
    //
    [RealmUtility insertObject:folder];
    
}

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)addButtonTouchUpInside:(id)sender {

    [self insertFolderWith:self.folderTextField.text];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
