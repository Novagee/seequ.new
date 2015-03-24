//
//  RingActivityTableViewController.m
//  Seequ
//
//  Created by Jose Correa on 2/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingActivityTableViewController.h"
#import "ActivityCell.h"
#import "RingStyleKit.h"
#import "RingActivityNetworkingManager.h"
#import <DejalActivityView/DejalActivityView.h>

@interface RingActivityTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dataSourceSegmentControl;

@property (strong, nonatomic) NSArray *activityArray;
@end

@implementation RingActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataSourceSegmentControl.tintColor = [RingStyleKit seequFoam];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:[ActivityCell cellIdentifier] bundle:nil]
     forCellReuseIdentifier:[ActivityCell cellIdentifier]];
    
    [self fetchActivityListWithFilter:self.dataSourceSegmentControl.selectedSegmentIndex];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.activityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:[ActivityCell cellIdentifier] forIndexPath:indexPath];

#warning The "configureCell" method has not implementation
    // Configure the cell
    //
    [cell configureCell:self.activityArray[indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ActivityCell cellHeight];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *_id = (self.activityArray[indexPath.row])[@"_id"];
        
        [[RingActivityNetworkingManager sharedInstance]deleteActivityWithID:_id body:@{} success:^(id successResponse) {
            
            NSLog(@"Delete activity: %@", successResponse);
            [self fetchActivityListWithFilter:self.dataSourceSegmentControl.selectedSegmentIndex];
            
        } failure:^(id failureResponse, NSError *error) {
            
        }];
    }
    
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
     return YES;
 }

#pragma mark - Control's Action

- (IBAction)dataSourceSegmentControlSwitch:(id)sender {
    
    // Activity list filter, change the data source or fetch again?
    //
    // .....
    [self fetchActivityListWithFilter:self.dataSourceSegmentControl.selectedSegmentIndex];
    
}

#pragma mark - Test Methods

- (IBAction)addTestButtonTouchUpInside:(id)sender {
    
    [[RingActivityNetworkingManager sharedInstance]addActivityWithBody:@{
                                                                         
                                                                         }
                                                               success:^(id successResponse) {
                                                                   
                                                                   NSLog(@"Add activity:: %@", successResponse);
                                                                   [self fetchActivityListWithFilter:self.dataSourceSegmentControl.selectedSegmentIndex];
                                                                   
                                                               } failure:^(id failureResponse, NSError *error) {
                                                                   
                                                                   NSLog(@"Error: %@", error);
                                                                   
                                                               }];
    
}

- (IBAction)deleteButtonTouchUpInside:(id)sender {
    
    NSString *_id = (self.activityArray.lastObject)[@"_id"];
    
    [[RingActivityNetworkingManager sharedInstance]deleteActivityWithID:_id body:@{} success:^(id successResponse) {
        
        NSLog(@"Delete activity: %@", successResponse);
        [self fetchActivityListWithFilter:self.dataSourceSegmentControl.selectedSegmentIndex];
        
    } failure:^(id failureResponse, NSError *error) {
        
    }];
    
}

-(void) fetchActivityListWithFilter:(NSUInteger)dataSourceType
{
    // Use the array below to convert the integet to string for "filter" field in HTTP "body"
    //
    NSArray *dataSourceTypeArray = @[@"...", @"commented", @"..."];
    
    [DejalActivityView activityViewForView:self.view withLabel:@"Loading ..."];
    
    [[RingActivityNetworkingManager sharedInstance] getActivityListWithBody:@{} success:^(id successResponse) {
        self.activityArray = (NSArray *)successResponse;
        
        NSLog(@"Fetch Activity: %@", successResponse);
        
        [self.tableView reloadData];
        [DejalActivityView removeView];
        
    } failure:^(id failureResponse, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                       message:@"Sorry something is wrong, please come back in a moment."
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [DejalActivityView removeView];

        [alert show];
        
    }];
    
}

@end
