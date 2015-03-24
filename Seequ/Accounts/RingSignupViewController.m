//
//  RingSignupViewController.m
//  Seequ
//
//  Created by Jose Correa on 2/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingSignupViewController.h"
#import "RingTextField.h"
#import "RingAccountNetworkingManager.h"

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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Hide keyboard when user taps on open space
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];    
}

- (IBAction)createAccountClicked:(id)sender {
    
    if ([self.firstNameTextfield.text isEqualToString:@""] || [self.lastNameTextfield.text isEqualToString:@""] || [self.passwordTextfield.text isEqualToString:@""] || [self.confirmPasswordTextfield.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please provide all required information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } else {
        [[RingAccountNetworkingManager sharedInstance] signUpWithFirstName:self.firstNameTextfield.text lastName:self.lastNameTextfield.text email:self.emailTextfield.text password:self.passwordTextfield.text success:^(id successResponse) {
            NSLog(@"Registion Success.");
            [self performSegueWithIdentifier:kSignUpProgressSegueID sender:self];

        } failure:^(id failureResponse, NSError *error) {
            NSLog(@"Registration Failure.");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Sorry something is wrong, please come back in a moment." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }];
    }
}

#pragma mark - Keyboard Notifications

- (void)keyboardDidShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self moveMainViewToPoint:CGPointMake(self.view.frame.origin.x, -keyboardFrame.size.height)];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self moveMainViewToPoint:CGPointMake(self.view.frame.origin.x, 0)];
}

#pragma mark - Move View

static const NSTimeInterval kAnimationDuration = 0.4;

- (void)moveMainViewToPoint:(CGPoint)location {
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(location.x,
                                                      location.y,
                                                      self.view.frame.size.width,
                                                      self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                     }
     ];
}

@end
