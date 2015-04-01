//
//  RingStyleKit+Extension.h
//  Seequ
//
//  Created by JB DeLima on 3/26/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//


#import "RingStyleKit.h"


typedef NS_ENUM(NSUInteger, RingStyleKitContactStatus) {
    RingStyleKitContactStatusAway = 1,
    RingStyleKitContactStatusBusy,
    RingStyleKitContactStatusActive,
    RingStyleKitContactStatusUnkown
};


@interface RingStyleKit (Extension)

+ (void)drawContactTableCellWithFrame:(CGRect)frame
                         profileImage:(UIImage *)profileImage
                numberOfNotifications:(NSInteger)notifications
                            firstName:(NSString *)firstName
                             lastName:(NSString *)lastName
                                title:(NSString *)jobTitle
                              company:(NSString *)company
                               status:(RingStyleKitContactStatus)status
                             favorite:(BOOL)favorite;

@end
