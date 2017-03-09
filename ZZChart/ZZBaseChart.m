//
//  ZZBaseChart.m
//  ZZBarchart
//
//  Created by songlu on 2017/3/3.
//  Copyright © 2017年 widget. All rights reserved.
//

#import "ZZBaseChart.h"

@implementation ZZBaseChart

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}


-(void)setUp{
    _playAniamtion = YES;
}

@end
