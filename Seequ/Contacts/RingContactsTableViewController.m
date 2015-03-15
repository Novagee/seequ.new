//
//  RingContactsTableViewController.m
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingContactsTableViewController.h"
#import "RingGenericContact.h"
#import "RingContactsTableViewCell.h"


@interface RingContactsTableViewController ()

@end


static const CGFloat kCellHeight = 64.0;


@implementation RingContactsTableViewController

- (void)setModel:(NSArray *)model {
    _model = [model copy];
    if (self.view.window) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const kCellIndentifier = @"kContactsTableViewCellIndetifier";
    
    RingContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier];
    RingGenericContact *contact = self.model[indexPath.row];
    
    cell.firstName = contact.firstName;
    cell.lastName  = contact.lastName;
    cell.company = contact.company;
    cell.jobTitle = contact.jobTitle;
    cell.favorite  = contact.type;
    cell.profileImage = contact.thumbnailImage;
    cell.numberOfNotifications = contact.numberOfNotifications;
    cell.favorite = contact.favorite;
    
    return cell;
}

@end
