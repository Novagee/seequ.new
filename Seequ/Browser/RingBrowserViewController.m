//
//  RingBrowserViewController.m
//  Seequ
//
//  Created by Jose Correa on 2/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingBrowserViewController.h"
#import "RingBrowserNavBarTextfield.h"
#import "RingBrowserButton.h"
#import <WebKit/WebKit.h>

static CGFloat const navBarHeight = 66.0f;
static CGFloat const tabBarHeight = 49.0f;

@interface RingBrowserViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet RingBrowserNavBarTextfield *browserURLTextfield;


@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIButton *browserURLTextfieldRefreshButton;

@end

@implementation RingBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Add Main View, aka a web view
    //
    _webView = [[WKWebView alloc] initWithFrame: CGRectMake(0, navBarHeight, self.view.frame.size.width, self.view.frame.size.height - navBarHeight - tabBarHeight)];
    
    // Load the "CNN.com" in default
    //
    NSURL *url = [NSURL URLWithString:@"http://cnn.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
    // Configure the refresh button in text field
    //
    _browserURLTextfieldRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _browserURLTextfieldRefreshButton.frame = CGRectMake(0, 0, 21, 21);
    [_browserURLTextfieldRefreshButton setImage:[UIImage imageNamed:@"brower_refresh"] forState:UIControlStateNormal];
    [_browserURLTextfieldRefreshButton addTarget:self action:@selector(browserURLTextfieldRefreshButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    // Configure url text field
    //
    self.browserURLTextfield.text = @"http://www.cnn.com";
    self.browserURLTextfield.rightViewMode = UITextFieldViewModeAlways;
    self.browserURLTextfield.rightView = self.browserURLTextfieldRefreshButton;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - HTTP Request Stuff

- (NSURL *)reconstructHTTPRequest:(NSString *)requestString {
    
    if ([requestString hasPrefix:@"http://"]) {
        return [NSURL URLWithString:requestString];
    }
    else {
        
        NSString *httpString = @"http://";
        NSString *reconstructedURLString = [httpString stringByAppendingString:requestString];
        
        return [NSURL URLWithString:reconstructedURLString];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.webView stopLoading];
    
    NSURL *url = [self reconstructHTTPRequest:textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark - Control's Actions

- (void)browserURLTextfieldRefreshButtonTouchUpInside:(id)sender {
    
    [self.webView reload];
    
}

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.webView stopLoading];
    [self.webView goBack];
    
}

- (IBAction)forwardButtonTouchUpInside:(id)sender {
    
    [self.webView stopLoading];
    [self.webView goForward];
    
}

- (IBAction)buddyButtonTouchUpInside:(id)sender {
    
}

@end
