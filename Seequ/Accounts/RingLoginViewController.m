//
//  RingLoginViewController.m
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingLoginViewController.h"
#import "RingUtility.h"
#import "RingTextField.h"
#import "AppDelegate.h"
#import "RingLoginProgressViewController.h"

#define kSignInProgressSegueID @"kLoginProgressStoryboardID"

@interface RingLoginViewController ()
@property (weak, nonatomic) IBOutlet RingTextField *account;
@property (weak, nonatomic) IBOutlet RingTextField *password;

@end

@implementation RingLoginViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setup];
    self.account.text = @"jb@seequ.com";
    self.password.text = @"secret";
}

-(void)setup
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.lockEmailField) {
        self.lockEmailField = NO;
        self.account.enabled = NO;
        self.account.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    AppDelegate *appDelegate = [AppDelegate sharedInstance];
    
    int netStatus = [appDelegate checkNetworkStatus];
    
    if (!netStatus) {
        UIAlertView *internetAlert = [[UIAlertView alloc] initWithTitle:@"Check Internet"
                                                                message:@"Please check your internet connection as the Seequ system does not seem to be accessible"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
        
        [internetAlert show];
        [self touchesBegan:nil withEvent:nil];
        
    } else {
        BOOL isRegistered = [[NSUserDefaults standardUserDefaults] boolForKey:@"autologin"];
        if (isRegistered) {
            NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            NSString *pass = [[NSUserDefaults standardUserDefaults] objectForKey:@"pass"];
            
            self.account.text = user;
            self.password.text = pass;
            
            [self SignInButtonClicked:nil];
            
            return;
        } else {
            [self.account becomeFirstResponder];
        }
    }
}

- (IBAction) SignInButtonClicked: (id)sender{
    
    if ([self.account.text isEqualToString:@""] || [self.password.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please provide the correct username and password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:kSignInProgressSegueID sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"kLoginProgressStoryboardID"]) {
        RingLoginProgressViewController *progressVC = segue.destinationViewController;
        progressVC.email = self.account.text;
        progressVC.password = self.password.text;
    }
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

-(void)dismissKeyboard {
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
}

@end
