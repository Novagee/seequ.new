//
//  RingOutgoingCallViewController.m
//  Seequ
//
//  Created by peng wan on 15-4-1.
//  Copyright (c) 2015年 Seequ. All rights reserved.
//

#import "RingOutgoingCallViewController.h"

typedef NS_ENUM(NSUInteger, kButtonStatus) {
    
    kButtonStatusDisable = 1000,
    kButtonStatusOn = 1001,
    kButtonStatusOff = 1002,
    
};

@interface RingOutgoingCallViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *callerNameLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *callTimeLabels;

@property (weak, nonatomic) IBOutlet UIView *buttonsBottom;
@property (weak, nonatomic) IBOutlet UIView *videoButtonsBottom;
@property (weak, nonatomic) IBOutlet UIView *labelBottom;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *muteButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *videoButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *speakerButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *messageButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *browserButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIView *declineButtonBottom;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *declineButtons;

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *tinyVideoView;

@property (strong, nonatomic) NSTimer *timer;
@property (assign) NSTimeInterval time;

@end

@implementation RingOutgoingCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureButtonStatus];
    [self configureCallViewStatus];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureButtonStatus {
    
    ((UIButton *)self.muteButtons[0]).tag = kButtonStatusOff;
    ((UIButton *)self.muteButtons[1]).tag = kButtonStatusOff;
    
    ((UIButton *)self.videoButtons[0]).tag = kButtonStatusOff;
    ((UIButton *)self.videoButtons[1]).tag = kButtonStatusOff;
    
    ((UIButton *)self.speakerButtons[0]).tag = kButtonStatusOff;
    ((UIButton *)self.speakerButtons[1]).tag = kButtonStatusOff;
    
}

- (void)configureCallViewStatus {
    
    _videoView.hidden = YES;
    
    _buttonsBottom.hidden = NO;
    _labelBottom.hidden = NO;
    _declineButtonBottom.hidden = NO;
    
}

- (void)configureVideoViewStatus {
    
    _videoView.hidden = NO;
    
    _buttonsBottom.hidden = YES;
    _labelBottom.hidden = YES;
    _declineButtonBottom.hidden = YES;
    
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
        
        [_muteButtons[0] setImage:[UIImage imageNamed:@"call_Mute_Active_Button"]
                         forState:UIControlStateNormal];
        ((UIButton *)_muteButtons[0]).tag = kButtonStatusOn;
        
        [_muteButtons[1] setImage:[UIImage imageNamed:@"call_Mute_Active_Button"]
                         forState:UIControlStateNormal];
        ((UIButton *)_muteButtons[1]).tag = kButtonStatusOn;
        
    }
    else {
        
        [_muteButtons[0] setImage:[UIImage imageNamed:@"call_Mute_Inactive_Button"]
                         forState:UIControlStateNormal];
        ((UIButton *)_muteButtons[0]).tag = kButtonStatusOff;
        
        [_muteButtons[1] setImage:[UIImage imageNamed:@"call_Mute_Inactive_Button"]
                         forState:UIControlStateNormal];
        ((UIButton *)_muteButtons[1]).tag = kButtonStatusOff;
        
    }
    
}

- (IBAction)videoButtonTouchUpInside:(id)sender {
    
    if (((UIButton *)sender).tag == kButtonStatusOff) {
        
        [_videoButtons[0] setImage:[UIImage imageNamed:@"call_Video_Active_Button"]
                          forState:UIControlStateNormal];
        ((UIButton *)_videoButtons[0]).tag = kButtonStatusOn;
        
        [_videoButtons[1] setImage:[UIImage imageNamed:@"call_Video_Active_Button"]
                          forState:UIControlStateNormal];
        ((UIButton *)_videoButtons[1]).tag = kButtonStatusOn;
        
        [self configureVideoViewStatus];
        
    }
    else {
        
        [_videoButtons[0] setImage:[UIImage imageNamed:@"call_Video_Inactive_Button"]
                          forState:UIControlStateNormal];
        ((UIButton *)_videoButtons[0]).tag = kButtonStatusOff;
        
        [_videoButtons[1] setImage:[UIImage imageNamed:@"call_Video_Inactive_Button"]
                          forState:UIControlStateNormal];
        ((UIButton *)_videoButtons[1]).tag = kButtonStatusOff;
        
        [self configureCallViewStatus];
    }
    
}

- (IBAction)speakerButtonTouchUpInside:(id)sender {
    
    if (((UIButton *)sender).tag == kButtonStatusOff) {
        
        [_speakerButtons[0] setImage:[UIImage imageNamed:@"call_Speaker_Active_Button"]
                            forState:UIControlStateNormal];
        ((UIButton *)_speakerButtons[0]).tag = kButtonStatusOn;
        
        [_speakerButtons[1] setImage:[UIImage imageNamed:@"call_Speaker_Active_Button"]
                            forState:UIControlStateNormal];
        ((UIButton *)_speakerButtons[1]).tag = kButtonStatusOn;
        
    }
    else {
        
        [_speakerButtons[0] setImage:[UIImage imageNamed:@"call_Speaker_Inactive_Button"]
                            forState:UIControlStateNormal];
        ((UIButton *)_speakerButtons[0]).tag = kButtonStatusOff;
        
        [_speakerButtons[1] setImage:[UIImage imageNamed:@"call_Speaker_Inactive_Button"]
                            forState:UIControlStateNormal];
        ((UIButton *)_speakerButtons[1]).tag = kButtonStatusOff;
        
    }
    
}

- (IBAction)messageButtonTouchUpInside:(id)sender {
    
}

- (IBAction)browserButtonTouchUpInside:(id)sender {
    
}

- (IBAction)profileButtonTouchUpInside:(id)sender {
    
}

- (IBAction)declineButtonTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
