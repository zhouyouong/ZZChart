//
//  ZZChartDelegate.h
//  ZZBarchart
//
//  Created by songlu on 2017/3/3.
//  Copyright © 2017年 widget. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ZZChartDelegate <NSObject>

@optional

-(void)userTouchAnXaxisIndex:(NSInteger)xIndex andYaxisIndex:(NSInteger)yIndex;

-(void)userTouchIndex:(NSInteger)index;

@end
