//
//  TestViewController.m
//  Seequ
//
//  Created by Paul on 3/20/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *collectionItems;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _collectionItems = [[NSMutableArray alloc]init];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionItems.count + 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        UICollectionViewCell *collectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"addButtonCell" forIndexPath:indexPath];
        collectionCell.backgroundColor = [UIColor redColor];
        return collectionCell;
    }
    UICollectionViewCell *collectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"contantCell" forIndexPath:indexPath];
    collectionCell.backgroundColor = self.collectionItems[indexPath.row - 1];
    return collectionCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UIColor *randomColor = [UIColor colorWithWhite:random()%1 alpha:1.0];
        [_collectionItems addObject:randomColor];
        [_collectionView reloadData];
        
        
    }
    
}

@end
