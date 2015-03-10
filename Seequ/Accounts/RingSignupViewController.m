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
#import "DCNetworkReactor.h"

#define kSignUpProgressSegueID @"signupProgress"

@interface RingSignupViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)createAccountClicked:(id)sender;

@property (weak, nonatomic) IBOutlet RingTextField *firstNameTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *lastNameTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *emailTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet RingTextField *confirmPasswordTextfield;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation RingSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

    // Init image picker
    //
    _imagePickerController = [[UIImagePickerController alloc]init];
    _imagePickerController.delegate = self;
    
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
        [[RingAccountManager sharedInstance] signUpWithFirstName:self.firstNameTextfield.text lastName:self.lastNameTextfield.text email:self.emailTextfield.text password:self.passwordTextfield.text success:^(id successResponse) {
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



- (IBAction)uploadPhotoButtobTouchUpInside:(id
                                            )sender {
    
    UIActionSheet *avatarTypeSheet = [[UIActionSheet alloc]initWithTitle:@"Choose you photo from" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", @"Take Photo", nil];
    [avatarTypeSheet showInView:self.view];
    
}

#pragma mark - UIActionSheet Delegate Method

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Configure the photo choose
    //
    if (buttonIndex == 0) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIPickerViewController Delegate Method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Configure the avatar
    //
    _avatarImageView.image = info[UIImagePickerControllerOriginalImage];

    // Handle upload stuff here
    //
#warning Upload image code here, PLZ fill it because I dont know the Server address
    [[DCNetworkReactor shareDCNetworkReactor]POST:@"upload address"
                                        withImage:self.avatarImageView.image
                               withAvatarDominate:@""
                                   withParameters:@{}
                                          success:^(id responseObject) {
        
                                        }
                                          failure:^(NSError *error) {
        
                                          }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
