//
//  RingMainViewController.m
//  Seequ
//
//  Created by peng wan on 15-2-10.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingMainViewController.h"
#import "RingStyleKit.h"

#import "RingConversationNetworkingManager.h"

@interface RingMainViewController ()

@end

@implementation RingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarItem *itemContact = [self.tabBar.items objectAtIndex:0];
    itemContact.image = [[RingStyleKit imageOfTab_bar_icon_contactsWithPressed:NO notifications:2525.0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemContact.selectedImage = [[RingStyleKit imageOfTab_bar_icon_contactsWithPressed:YES notifications:0.0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemMessage = [self.tabBar.items objectAtIndex:1];
    itemMessage.image = [[RingStyleKit imageOfTab_bar_icon_messagesWithPressed:NO notifications:123.0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemMessage.selectedImage = [[RingStyleKit imageOfTab_bar_icon_messagesWithPressed:YES notifications:0.0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemBrowser = [self.tabBar.items objectAtIndex:2];
    itemBrowser.image = [[RingStyleKit imageOfTab_bar_icon_browserWithPressed:NO notifications:21.0 buddybrowse:NO] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemBrowser.selectedImage = [[RingStyleKit imageOfTab_bar_icon_browserWithPressed:YES notifications:0.0 buddybrowse:YES] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *itemActivity = [self.tabBar.items objectAtIndex:3];
    itemActivity.image = [[RingStyleKit imageOfTab_bar_icon_activityWithPressed:NO notifications:3.0]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemActivity.selectedImage = [[RingStyleKit imageOfTab_bar_icon_activityWithPressed:YES notifications:0.0]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *itemTakes = [self.tabBar.items objectAtIndex:4];
    itemTakes.image = [[RingStyleKit imageOfTab_bar_icon_takesWithPressed:NO notifications:4.0]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemTakes.selectedImage = [[RingStyleKit imageOfTab_bar_icon_takesWithPressed:YES notifications:0.0]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    [[RingConversationNetworkingManager sharedInstance] createConversationWithBody:@{} success:^(id successResponse) {
        
        NSLog(@"Success: %@", successResponse);
        
        [[RingConversationNetworkingManager sharedInstance] inviteConversationUser:@"54ff1e392845ae83522fd566" success:^(id successResponse) {
        
            NSLog(@"Success: %@", successResponse);
            
        } failure:^(id failureResponse, NSError *error) {
            
        }];
        
    } failure:^(id failureResponse, NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
