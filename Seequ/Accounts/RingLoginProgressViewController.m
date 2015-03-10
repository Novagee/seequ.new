//
//  RingLoginProgressViewController.m
//  Seequ
//
//  Created by peng wan on 15-2-13.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingLoginProgressViewController.h"
#import "progressView.h"
#import "RingAccountManager.h"
#import "RingContactAPIManager.h"

#define loginSuccessSegueID @"kLoginSuccessSegueID"

@interface RingLoginProgressViewController ()
@property (weak, nonatomic) IBOutlet progressView *progressView;

@end

@implementation RingLoginProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.progressView.percentage = 0;
    [self.progressView setNeedsDisplay];
    
    [self performSelector:@selector(loadOneThird) withObject:nil afterDelay:0.5];
    
    [self performSelector:@selector(loadTwoThird) withObject:nil afterDelay:1];

    [self performSelector:@selector(loginAction) withObject:nil afterDelay:1.5];
}

-(void) loadOneThird
{
    self.progressView.percentage = 33;
    [self.progressView setNeedsDisplay];
}

-(void) loadTwoThird
{
    self.progressView.percentage = 66;
    [self.progressView setNeedsDisplay];
}

-(void)loginAction
{
        __weak RingLoginProgressViewController *weakSelf = self;
    
        [[RingAccountManager sharedInstance] signInWithEmail:self.email password:self.password success:^(id successResponse) {
            
            weakSelf.progressView.percentage = 100;
            [weakSelf.progressView setNeedsDisplay];
            
            [[RingContactAPIManager sharedInstance] getGroupListWithSuccess:^(id successResponse) {
                [weakSelf performSelector:@selector(pushToMainScreen) withObject:nil afterDelay:0.5];
            
            } failure:^(id failureResponse, NSError *error) {
                NSLog(@"Group List Failure");
                 [self didFail];
            }];
        
        } failure:^(id failure, NSError *error) {
            NSLog(@"Signin Failure");
            [self didFail];
        }];
}

-(void) pushToMainScreen
{
    [self performSegueWithIdentifier:loginSuccessSegueID sender:self];
}

- (void)didFail {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:@"Sorry something is wrong, please come back in a moment."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

@end
