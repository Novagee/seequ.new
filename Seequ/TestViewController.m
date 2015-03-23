//
//  TestViewController.m
//  Seequ
//
//  Created by Paul on 3/20/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "TestViewController.h"
#import "RingContactNetworkingManager.h"
#import "User.h"

@interface TestViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *contacts;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _contacts =[[NSMutableArray alloc]init];
    
    // Hard code for test
    //
    NSMutableArray *colors = [[NSMutableArray alloc]init];;
    UIColor *color = [UIColor redColor];
    [colors addObject:color];

    [_contacts addObject:colors];
    
    //[self fetchContantDataFromRemote];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchContantDataFromRemote {
    
    _contacts = [[NSMutableArray alloc]init];
    
    [[RingContactNetworkingManager sharedInstance] getGroupListWithSuccess:^(id successResponse) {
        
        [_contacts addObjectsFromArray:successResponse[0][@"contacts"]];
        
        [self.collectionView reloadData];
        
    } failure:^(id failureResponse, NSError *error) {
        
    }];
    
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // Hard code for test
    //
    if (self.contacts.count > 0 && section < self.contacts.count) {
        return ((NSArray *)self.contacts[section]).count + 1;
    }
    return  1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.contacts.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == self.contacts.count) {
        
        UICollectionViewCell *collectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"addGroupCell" forIndexPath:indexPath];
        return collectionCell;
        
    }
    
    if (indexPath.row == 0) {
        UICollectionViewCell *collectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"addContactCell" forIndexPath:indexPath];
        return collectionCell;
    }
    
    UICollectionViewCell *collectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"contantCell" forIndexPath:indexPath];
    collectionCell.backgroundColor = [UIColor cyanColor];
    return collectionCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == self.contacts.count){
        
        // Add new group code here
        //
        // ......
        
        NSMutableArray *colors = [[NSMutableArray alloc]init];;
        [_contacts addObject:colors];
        
        [_collectionView reloadData];
    }
    if (indexPath.row == 0) {
        
        // Add new contact code here
        //
        // ......
        
        NSMutableArray *colors = self.contacts[indexPath.section];
        UIColor *color = [UIColor redColor];
        [colors addObject:color];
        
        [_collectionView reloadData];
        
    }
    
}

@end
