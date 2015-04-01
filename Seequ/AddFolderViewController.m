
//  AddFolderViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "AddFolderViewController.h"
#import "RingRealmManager.h"
#import "Folder.h"
#import "RingStyleKit.h"

@interface AddFolderViewController ()< UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *folderTextField;
@property (nonatomic, strong) RingRealmManager *realmManager;

@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *navBarViewLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation AddFolderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_folderTextField becomeFirstResponder];
    
    self.navBarView.backgroundColor = [RingStyleKit seequFoam];
    self.navBarViewLabel.textColor = [RingStyleKit white];
    [self.cancelButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
    [self.addButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
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
    
    folder._id = [RingRealmManager validIndexFrom:[Folder class]];
    folder.name = folderTitle;
    folder.ancestorName = self.currentFolder.name;
    folder.ancestorID = self.currentFolder._id;
    folder.saveDate = [NSDate date];
    
    // Commit the change
    //
    [RingRealmManager addObject:folder];
    
}

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)addButtonTouchUpInside:(id)sender {
    
    if (![self.folderTextField.text isEqualToString:@""]) {
        [self insertFolderWith:self.folderTextField.text];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter the folder name." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
}

@end
