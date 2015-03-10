
//  AddFolderViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RealmUtility.h"
#import "AddFolderViewController.h"

@interface AddFolderViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView dequeueReusableCellWithIdentifier:@"EditTitle" forIndexPath:indexPath];
    
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
        Folder *folder = [[Folder alloc]init];
        folder.name = textField.text;
        folder.ancestorName = self.currentFolder.name;
        folder._id = [RealmUtility validIndexFrom:[Folder class]];
        [RealmUtility insertObject:folder];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    return YES;
}

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
