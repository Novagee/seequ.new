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
#import "BookmarkViewController.h"

static CGFloat const navBarHeight = 66.0f;
static CGFloat const tabBarHeight = 49.0f;

@interface RingBrowserViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet RingBrowserButton *prevArrowButton;
@property (weak, nonatomic) IBOutlet RingBrowserButton *nextArrowButton;
@property (weak, nonatomic) IBOutlet RingBrowserButton *buddyBrowserButton;
@property (weak, nonatomic) IBOutlet RingBrowserButton *bookmarkButton;
@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet RingBrowserNavBarTextfield *browserURLTextfield;
@property (strong, nonatomic) RingBrowserRefreshButton *refreshButton;
@end

@implementation RingBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.webView = [[WKWebView alloc] initWithFrame: CGRectMake(0, navBarHeight, self.view.frame.size.width, self.view.frame.size.height - navBarHeight - tabBarHeight)];
                          
    NSURL *url = [NSURL URLWithString:@"http://cnn.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    self.refreshButton = [[RingBrowserRefreshButton alloc] initWithFrame:CGRectMake(0, 0, 13, 12)];
    [self.refreshButton addTarget:self action:@selector(browserURLTextfieldRefreshButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    self.browserURLTextfield.rightView = self.refreshButton;
    self.browserURLTextfield.text = @"http://www.cnn.com";
    self.browserURLTextfield.rightViewMode = UITextFieldViewModeAlways;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Control's Actions

- (void)browserURLTextfieldRefreshButtonTouchUpInside:(id)sender {
    
    [self.webView reload];
    
}

- (IBAction)prevArrowClick:(id)sender {
    [self.webView stopLoading];
    [self.webView goBack];
}

- (IBAction)nextArrowClick:(id)sender {
    [self.webView stopLoading];
    [self.webView goForward];
}

@end
