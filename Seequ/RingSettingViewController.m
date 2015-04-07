//
//  RingSettingViewController.m
//  Seequ
//
//  Created by Paul on 4/7/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingSettingViewController.h"
#import "RingAccountNetworkingManager.h"
#import <DejalActivityView/DejalActivityView.h>

@interface RingSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *settingItems;

@end

@implementation RingSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _settingItems = [[NSArray alloc] initWithObjects:
                  @"Profile Visible",
                  @"Audio Call on Speaker",
                  @"Headset on Proximity",
                  @"Mute",
                  @"Billing",
                  @"Double take",
                  @"Muted Members",
                  @"Help",
                  @"Make a Suggestion",
                  @"Report a Problem",
                  @"Terms, Privacy & Acceptable Use",
                  @"Change Password",
                  @"About", nil];
    
    
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

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.settingItems.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (indexPath.row < 4) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UISwitch *switch_ = [[UISwitch alloc] init];
        [switch_ addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [switch_ setOnTintColor:[UIColor colorWithRed:112.0/255.0 green:173.0/255.0 blue:192.0/255.0 alpha:1]];
        switch_.tag = indexPath.row;
        switch_.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 30, 22);
        [cell addSubview:switch_];
        
        // Load switch status
        //
        switch (indexPath.row) {
                
            case 0: {
                [switch_ setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"online"]];
            }
                break;
            case 1: {
                [switch_ setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"DefaultAudioOutputInAudioCall"]];
            }
                break;
            case 2: {
                [switch_ setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"ProximityAudioOutputChange"]];
            }
                break;
            case 3: {
                [switch_ setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Mute"]];
            }
                break;
            default:
                break;
        }

        
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.settingItems[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)switchValueChanged:(id)sender {
    UISwitch *switch_ = (UISwitch*)sender;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    switch (switch_.tag) {
        case 0: {
            [userDef setBool:switch_.on forKey:@"online"];
        }
            break;
        case 1: {
            [userDef setBool:switch_.on forKey:@"DefaultAudioOutputInAudioCall"];
        }
            break;
        case 2: {
            [userDef setBool:switch_.on forKey:@"ProximityAudioOutputChange"];
        }
            break;
        case 3: {
            [userDef setBool:switch_.on forKey:@"Mute"];
        }
            break;
            
        default:
            break;
    }
}


- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)logOutButtonTouchUpInside:(id)sender {
    
    [DejalActivityView activityViewForView:self.view withLabel:@"Logging out ..."];
    
    [[RingAccountNetworkingManager sharedInstance] signOutWithSuccess:^(id successResponse) {
       
        [self.navigationController popToRootViewControllerAnimated:NO];
        [DejalActivityView removeView];
        
    } failure:^(id failureResponse, NSError *error) {
        
        [DejalActivityView removeView];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Log out failure" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
    }];
    
}

@end
