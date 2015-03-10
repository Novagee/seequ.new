
#import "RingContactsTableViewController.h"
#import "RingGenericContact.h"


@interface RingContactsTableViewController ()

@end


@implementation RingContactsTableViewController

- (void)setModel:(NSArray *)model {
    _model = [model copy];
    if (self.view.window) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const kCellIndentifier = @"kContactsTableViewCellIndetifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier];
    RingGenericContact *contact = self.model[indexPath.row];
    
    cell.textLabel.text = contact.fullName;
    cell.detailTextLabel.text = contact.email;
    
    cell.imageView.image = contact.thumbnailImage;
    cell.imageView.layer.cornerRadius = cell.imageView.image.size.height/2.0;
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

@end
