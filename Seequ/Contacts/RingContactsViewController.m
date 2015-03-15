//
//  RingContactsViewController.m
//  Seequ
//
//  Created by JB DeLima on 3/9/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingContactsViewController.h"
#import "RingContactsTableViewController.h"
#import "RingGenericContact.h"
#import "Contact.h"
#import "RingStyleKit.h"
#import <Realm/Realm.h>
@import AddressBook;


@interface RingContactsViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *dataSourceSegmentControl;

@property (nonatomic, strong) RingContactsTableViewController *contactsTBVC;
@property (nonatomic, strong) NSArray *addressBookContacts;
@property (nonatomic, strong) NSArray *seequContacts;
@property (nonatomic, strong) RLMNotificationToken *realmNotification;

@end


@implementation RingContactsViewController

typedef NS_ENUM(NSUInteger, DataSourceSegmentControlSelection) {
    DataSourceSegmentControlSelectionPhone = 0,
    DataSourceSegmentControlSelectionSeequ = 1,
    DataSourceSegmentControlSelectionFavorites = 2
};

static NSString *const kDefaultContactImageName = @"default-contact.png";
static NSString *const kAddressBookAccessNotAuthorized = @"This application is not authorized to access your contacts. Please go to Settings → Privacy → Contacts to grant permission.";

#pragma mark - View Controller Lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[RingContactsTableViewController class]]) {
        self.contactsTBVC = segue.destinationViewController;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.translucent = NO;
    navBar.barTintColor = [RingStyleKit seequFoam];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[RingStyleKit white]};
    self.dataSourceSegmentControl.tintColor = [RingStyleKit seequFoam];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.dataSourceSegmentControl.selectedSegmentIndex == DataSourceSegmentControlSelectionPhone) {
        [self fetchAddressBookContacts];
    } else if (self.dataSourceSegmentControl.selectedSegmentIndex == DataSourceSegmentControlSelectionSeequ) {
        [self fetchSeequContacts];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    __weak RingContactsViewController *weakSelf = self;
    self.realmNotification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *note, RLMRealm *realm) {
        [weakSelf seequContactDidChange:note inRealm:realm];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [RLMRealm.defaultRealm removeNotification:self.realmNotification];
    self.realmNotification = nil;
}

#pragma mark - Notifications

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self fetchAddressBookContacts]; //In case the user exited the app, modified the Address Book Contacts, then came back (unfortunately there's no notification that tells us when a change occurs in the Address Book)
}

- (void)seequContactDidChange:(NSString *)note inRealm:(RLMRealm *)realm {
    [self fetchSeequContacts];
}

#pragma mark - Target Action

- (IBAction)segmentControlValueDidChange:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == DataSourceSegmentControlSelectionPhone) {
        if (self.addressBookContacts) {
            self.contactsTBVC.model = self.addressBookContacts;
        } else {
            [self fetchAddressBookContacts];
        }
    
    } else if (sender.selectedSegmentIndex == DataSourceSegmentControlSelectionSeequ) {
        if (self.seequContacts) {
            self.contactsTBVC.model = self.seequContacts;
        } else {
            [self fetchSeequContacts];
        }
        
    } else if (sender.selectedSegmentIndex == DataSourceSegmentControlSelectionFavorites) {
        //TEMPORARY
        self.contactsTBVC.model = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Contacts From Address Book
///////////////////////////////////////////////////////////////////////////////////////////

- (void)fetchAddressBookContacts {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        [self adddressBookAccessGranted];
    
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self adddressBookAccessGranted];
                } else {
                    [self addressBookAccessNotGranted];
                }
            });
        });
        
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
               ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        [self addressBookAccessNotGranted];
    }
}

- (void)adddressBookAccessGranted {
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    NSArray *contactList = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    NSMutableArray *contacts = [NSMutableArray array];
    
    for (id record in contactList) {
        
        ABRecordRef contact = (__bridge ABRecordRef)record;
        
        UIImage *contactThumbnailImage;
        if (ABPersonHasImageData(contact)){
            NSData *data = (__bridge NSData *)ABPersonCopyImageDataWithFormat(contact, kABPersonImageFormatThumbnail);
            contactThumbnailImage = [UIImage imageWithData:data];
        } else {
            contactThumbnailImage = [UIImage imageNamed:kDefaultContactImageName];
        }
        
        CGSize size = CGSizeMake(35, 35);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        [contactThumbnailImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *resizedThumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSString *fName = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonCompositeNameFormatFirstNameFirst);
        NSString *lName = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonCompositeNameFormatLastNameFirst);
        NSString *company = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonOrganizationProperty);
        NSString *jobTitle = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonJobTitleProperty);
        
        ABMultiValueRef emails = ABRecordCopyValue(contact, kABPersonEmailProperty);
        
        for (NSUInteger i = 0; i < ABMultiValueGetCount(emails); i++) {
            NSString *email = (__bridge NSString *) ABMultiValueCopyValueAtIndex(emails, i);
            NSError *error = nil;
            RingGenericContact *c = [RingGenericContact genericContactWithType:RingGenericContactTypeAddressBook
                                                                  andFirstName:fName ? fName : @""
                                                                      lastName:lName ? lName : @""
                                                                andCompanyName:company ? company : @""
                                                                   andJobTitle:jobTitle ? jobTitle : @""
                                                                  emailAddress:email ? email : @""
                                                             andThumbnailImage:resizedThumbnail
                                                                      favorite:NO
                                                         numberOfNotifications:0
                                                                         error:&error];
            if (!error) {
                [contacts addObject:c];
            }
        }
    }
    [contacts sortedArrayUsingSelector:@selector(compare:)];
    
    self.addressBookContacts = [contacts copy];
    self.contactsTBVC.model = self.addressBookContacts;
}

- (void)addressBookAccessNotGranted {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:kAddressBookAccessNotAuthorized
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Contacts From Seequ
///////////////////////////////////////////////////////////////////////////////////////////


- (void)fetchSeequContacts {
    /*
     RLMResults *contactsFromRealm = [Contact allObjects];
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithCapacity:[contactsFromRealm count]];
    for (Contact *c in contactsFromRealm) {
        NSError *error = nil;
        
        RingGenericContact *c = [RingGenericContact genericContactWithFirstName:@""
                                                                       lastName:lName ? lName : @""
                                                                   emailAddress:(__bridge NSString *)email
                                                              andThumbnailImage:resizedThumbnail
                                                                          error:&error];
        if (!error) {
            [contacts addObject:c];
        }
    }
    self.seequContacts = [contacts copy];
     */
    self.contactsTBVC.model = nil;
}

@end
