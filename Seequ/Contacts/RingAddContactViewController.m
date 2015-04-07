//
//  RingAddContactViewController.m
//  Seequ
//
//  Created by peng wan on 15-3-20.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "RingAddContactViewController.h"
#import "RingContactNetworkingManager.h"
#import "RingTextField.h"

#import "RingSettingViewController.h"

@interface RingAddContactViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *groups;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet RingTextField *groupNameTextfield;

@end

@implementation RingAddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Collection View";
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AddCell"];
    [self fetchContantDataFromRemote];
    // Do any additional setup after loading the view from its nib.
}

- (void)fetchContantDataFromRemote {
    
    [[RingContactNetworkingManager sharedInstance] getGroupListWithSuccess:^(id successResponse) {
        
        self.groups = [NSArray arrayWithArray:successResponse];
        [self.collectionView reloadData];
        
    } failure:^(id failureResponse, NSError *error) {
        
    }];
}

- (void)createNewGroup
{
    if ([self.groupNameTextfield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please provide a valid group name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [[RingContactNetworkingManager sharedInstance] createGroupWithName:self.groupNameTextfield.text success:^(id successResponse) {
            self.groupNameTextfield.text = @"";
            [self fetchContantDataFromRemote];
        } failure:^(id failureResponse, NSError *error) {
            
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.groups.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = nil;
    static NSString *identifier_add = @"AddCell";
    static NSString *identifier_group = @"GroupCell";
    
    if (indexPath.row == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_add forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add.png"]];
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton addTarget:self action:@selector(createNewGroup) forControlEvents:UIControlEventTouchUpInside];
        addButton.frame = cell.contentView.frame;
        [cell.contentView addSubview:addButton];
        
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_group forIndexPath:indexPath];
        
        UIImageView *iVatarImageView = (UIImageView *)[cell viewWithTag:100];
        iVatarImageView.image = [UIImage imageNamed:@"group.png"];
        UILabel *groupNameLbl = (UILabel *)[cell viewWithTag:200];
        groupNameLbl.text = [self.groups[indexPath.row-1] objectForKey:@"name"];
    }
    
    return cell;
}

- (IBAction)settingButtonTouchUpInside:(id)sender {

    RingSettingViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RingSetting"];
    [self.navigationController pushViewController:settingViewController animated:YES];
    
}

@end
