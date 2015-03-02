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
#import "RingBrowserRefreshButton.h"

#import <WebKit/WebKit.h>

static CGFloat const navBarHeight = 66.0f;
static CGFloat const tabBarHeight = 49.0f;

@interface RingBrowserViewController ()
@property (weak, nonatomic) IBOutlet RingBrowserButton *prevArrowButton;
@property (weak, nonatomic) IBOutlet RingBrowserButton *nextArrowButton;
@property (weak, nonatomic) IBOutlet RingBrowserButton *buddyBrowserButton;
@property (weak, nonatomic) IBOutlet RingBrowserButton *bookmarkButton;

@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet RingBrowserNavBarTextfield *browserURLTextfield;
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
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];
    
    // Load the "CNN.com" in default
    //
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(0, 0, 12, 12);
    [refreshButton setImage:[UIImage imageNamed:@"brower_refresh"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(browserURLTextfieldRefreshButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    // Configure url text field
    //
    self.browserURLTextfield.rightView = refreshButton;
    self.browserURLTextfield.text = @"http://www.cnn.com";
    self.browserURLTextfield.rightViewMode = UITextFieldViewModeAlways;
    
    
    
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Control's Actions

- (void)browserURLTextfieldRefreshButtonTouchUpInside:(id)sender {
    
    [self.webView reload];
    
}

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

- (IBAction)prevArrowClick:(id)sender {
    [self.webView stopLoading];
    [self.webView goBack];
}

- (IBAction)nextArrowClick:(id)sender {
    [self.webView stopLoading];
    [self.webView goForward];
}
- (IBAction)bookmarkClick:(id)sender {
}

@end
