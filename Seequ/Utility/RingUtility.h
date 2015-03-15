//
//  RingUtility.h
//  Seequ
//
//  Created by peng wan on 15-2-8.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RingUtility : NSObject

+ (void)setupStatusBarForView:(UIView *)superView;

+ (CGSize) screenSize;

+ (BOOL)isValidEmail:(NSString*)email;

@end
