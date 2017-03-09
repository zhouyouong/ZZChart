//
//  ZZLabel.m
//  ZZBarchart
//
//  Created by songlu on 2017/3/3.
//  Copyright © 2017年 widget. All rights reserved.
//

#import "ZZLabel.h"

@implementation ZZLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:10];
        self.numberOfLines = 0;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

@end
