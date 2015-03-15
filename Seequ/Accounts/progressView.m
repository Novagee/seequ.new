//
//  progressView.m
//  Seequ
//
//  Created by peng wan on 15-2-13.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "progressView.h"
#import "RingStyleKit.h"

@implementation progressView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [RingStyleKit drawLogin_progress_graphWithProgressPercent:self.percentage];

}

@end
