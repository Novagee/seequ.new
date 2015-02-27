//
//  RingBrowserViewController.m
//  Seequ
//
//  Created by Jose Correa on 2/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingBrowserViewController.h"
#import <WebKit/WebKit.h>

static CGFloat const navBarHeight = 66.0f;
static CGFloat const tabBarHeight = 49.0f;

@interface RingBrowserViewController ()

@end

@implementation RingBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    WKWebView *webView = [[WKWebView alloc] initWithFrame: CGRectMake(0, navBarHeight, self.view.frame.size.width, self.view.frame.size.height - navBarHeight - tabBarHeight)];
                          
    NSURL *url = [NSURL URLWithString:@"http://cnn.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
    
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

@end
