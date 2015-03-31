//
//  RingIncomeCallViewController.m
//  Seequ
//
//  Created by Paul on 3/31/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingIncomeCallViewController.h"

typedef NS_ENUM(NSUInteger, kButtonStatus) {
    
    kButtonStatusDisable = 1000,
    kButtonStatusOn = 1001,
    kButtonStatusOff = 1002,
    
};

@interface RingIncomeCallViewController ()

@property (weak, nonatomic) IBOutlet UILabel *callerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *callStatusLabel;

@property (weak, nonatomic) IBOutlet UIButton *muteButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UIButton *speakerButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *browserButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;

@end

@implementation RingIncomeCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureButtonStatus];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureButtonStatus {
    
    _muteButton.tag = kButtonStatusOff;
    _videoButton.tag = kButtonStatusOff;
    _speakerButton.tag = kButtonStatusOff;
    _messageButton.tag = kButtonStatusOff;
    _browserButton.tag = kButtonStatusOff;
    _profileButton.tag = kButtonStatusOff;
    _answerButton.tag = kButtonStatusOff;
    _declineButton.tag = kButtonStatusOff;
    _replyButton.tag = kButtonStatusOff;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)muteButtonTouchUpInside:(id)sender {
    
    if (((UIButton *)sender).tag == kButtonStatusOff) {
        
        [_muteButton setImage:[UIImage imageNamed:@"call_Mute_Active_Button"]
                               forState:UIControlStateNormal];
        ((UIButton *)sender).tag = kButtonStatusOn;
        
    }
    else {
        
        [_muteButton setImage:[UIImage imageNamed:@"call_Mute_Inactive_Button"]
                               forState:UIControlStateNormal];
        ((UIButton *)sender).tag = kButtonStatusOff;
        
    }
    
}

- (IBAction)videoButtonTouchUpInside:(id)sender {
    
    if (((UIButton *)sender).tag == kButtonStatusOff) {
        
        [_videoButton setImage:[UIImage imageNamed:@"call_Video_Active_Button"]
                        forState:UIControlStateNormal];
        ((UIButton *)sender).tag = kButtonStatusOn;
        
    }
    else {
        
        [_videoButton setImage:[UIImage imageNamed:@"call_Video_Inactive_Button"]
                        forState:UIControlStateNormal];
        ((UIButton *)sender).tag = kButtonStatusOff;
        
    }
    
}

- (IBAction)speakerButtonTouchUpInside:(id)sender {
    
    if (((UIButton *)sender).tag == kButtonStatusOff) {
        
        [_speakerButton setImage:[UIImage imageNamed:@"call_Speaker_Active_Button"]
                      forState:UIControlStateNormal];
        ((UIButton *)sender).tag = kButtonStatusOn;
        
    }
    else {
        
        [_speakerButton setImage:[UIImage imageNamed:@"call_Speaker_Inactive_Button"]
                      forState:UIControlStateNormal];
        ((UIButton *)sender).tag = kButtonStatusOff;
        
    }
    
}

- (IBAction)messageButtonTouchUpInside:(id)sender {
    
}

- (IBAction)browserButtonTouchUpInside:(id)sender {
    
}

- (IBAction)profileButtonTouchUpInside:(id)sender {
    
}

- (IBAction)answerButtonTouchUpInside:(id)sender {
    
}

- (IBAction)declineButtonTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)replyButtonTouchUpInside:(id)sender {
    
}

@end
