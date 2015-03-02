//
//  progressView.m
//  Seequ
//
//  Created by peng wan on 15-2-13.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "progressView.h"
#import "App_StyleKit.h"

@implementation progressView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [App_StyleKit drawLogin_progress_graphWithProgressPercent:self.percentage];

}

@end
