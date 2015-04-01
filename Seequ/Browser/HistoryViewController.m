//
//  HistoryViewController.m
//  Seequ
//
//  Created by Peng Wan on 3/3/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "HistoryViewController.h"
#import "Bookmark.h"
#import "RingStyleKit.h"

@interface HistoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *bookmarkList;

@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *navBarViewLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIView *bottomNavView;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _bookmarkList = [[NSMutableArray alloc]init];
    
    self.navBarView.backgroundColor = [RingStyleKit seequFoam];
    self.navBarViewLabel.textColor = [RingStyleKit white];
    [self.doneButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
    
    self.bottomNavView.backgroundColor = [RingStyleKit seequFoam];
    [self.cleanButton setTitleColor:[RingStyleKit white] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBookmarkList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureBookmarkList {
    
    [_bookmarkList removeAllObjects];
    
    RLMResults *bookmarks = [Bookmark objectsWhere:@"folderID = 2"];
    
    for (NSUInteger index = 0; index < bookmarks.count; index++) {
        
        Bookmark *bookmark = [bookmarks objectAtIndex:index];
        [_bookmarkList addObject:bookmark];
    
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bookmarkList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    cell.textLabel.text = ((Bookmark *)self.bookmarkList[indexPath.row]).url;
    cell.detailTextLabel.text = ((Bookmark *)self.bookmarkList[indexPath.row]).name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *urlString = ((Bookmark *)self.bookmarkList[indexPath.row]).url;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SeeNotificationLoadURL"
                                                       object:nil
                                                     userInfo:@{
                                                                @"url": urlString
                                                                }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)doneButtonTouchUpInside:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
