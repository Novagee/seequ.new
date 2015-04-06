//
//  RingMainViewController.m
//  Seequ
//
//  Created by peng wan on 15-2-10.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingMainViewController.h"
#import "RingStyleKit.h"


@interface RingMainViewController ()

@end


@implementation RingMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UINavigationController *vc;
    NSMutableArray *arr = [NSMutableArray array];
    
    vc = [[UIStoryboard storyboardWithName:@"Contacts" bundle:nil] instantiateInitialViewController];
    [arr addObject:vc.viewControllers.firstObject];
    
    vc = [[UIStoryboard storyboardWithName:@"Messages" bundle:nil] instantiateInitialViewController];
    [arr addObject:vc.viewControllers.firstObject];
    
    vc = [[UIStoryboard storyboardWithName:@"Browser" bundle:nil] instantiateInitialViewController];
    [arr addObject:vc.viewControllers.firstObject];
    
    vc = [[UIStoryboard storyboardWithName:@"Activity" bundle:nil] instantiateInitialViewController];
    [arr addObject:vc.viewControllers.firstObject];
    
    vc = [[UIStoryboard storyboardWithName:@"Takes" bundle:nil] instantiateInitialViewController];
    [arr addObject:vc.viewControllers.firstObject];
    
    self.viewControllers = [arr copy];
}

@end
