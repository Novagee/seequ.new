//
//  RingSignupViewController.m
//  Seequ
//
//  Created by Jose Correa on 2/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingSignupViewController.h"
#import "RingTextField.h"
#import "RingAccountManager.h"
#import "UserInfo.h"

#define kSignUpProgressSegueID @"signupProgress"

@interface RingSignupViewController ()

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)createAccountClicked:(id)sender;

@property (weak, nonatomic) IBOutlet RingTextField *firstNameTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *lastNameTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *emailTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *confirmPasswordTextfield;
@end

@implementation RingSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:NO];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (IBAction)createAccountClicked:(id)sender {
    
    if ([self.firstNameTextfield.text isEqualToString:@""] || [self.lastNameTextfield.text isEqualToString:@""] || [self.passwordTextfield.text isEqualToString:@""] || [self.confirmPasswordTextfield.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please provide all required information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } else {
        [[RingAccountManager sharedInstance] registerWithEmail:self.emailTextfield.text Password:self.passwordTextfield.text success:^(id successResponse) {

            NSLog(@"Registion Success.");
            UserInfo *seequUser = (UserInfo *)successResponse;
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                
                // Get realm and table instances for this thread
                RLMRealm *realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                [realm addObject:seequUser];
                // Commit the write transaction
                // to make this data available to other threads
                [realm commitWriteTransaction];
            });

            [self performSegueWithIdentifier:kSignUpProgressSegueID sender:self];
            
        } failure:^(id failureResponse, NSError *error) {
            
            NSLog(@"Registration Failure.");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Sorry something is wrong, please come back in a moment." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }];
    }
}

@end
