//
//  RingActivityTableViewController.m
//  Seequ
//
//  Created by Jose Correa on 2/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingActivityTableViewController.h"
#import "ActivityCell.h"

@interface RingActivityTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *callsButton;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@end

@implementation RingActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:[ActivityCell cellIdentifier] bundle:nil]
     forCellReuseIdentifier:[ActivityCell cellIdentifier]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ActivityCell cellIdentifier] forIndexPath:indexPath];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ActivityCell cellHeight];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)segmentButtonTouchUpInside:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    switch (button.tag) {
        case 1: {
            
            [self.allButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_All_On"] forState:UIControlStateNormal];
            [self.callsButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_Calls_Off"] forState:UIControlStateNormal];
            [self.requestButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_Requests_Off"] forState:UIControlStateNormal];
        }
            break;
        case 2: {
            
            [self.allButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_All_Off"] forState:UIControlStateNormal];
            [self.callsButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_Calls_On"] forState:UIControlStateNormal];
            [self.requestButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_Requests_Off"] forState:UIControlStateNormal];
        }
            break;
        case 3: {
            
            [self.allButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_All_Off"] forState:UIControlStateNormal];
            [self.callsButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_Calls_Off"] forState:UIControlStateNormal];
            [self.requestButton setBackgroundImage:[UIImage imageNamed:@"activity_Segment_Requests_On"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
}

@end
