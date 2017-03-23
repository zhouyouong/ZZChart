//
//  ZZBarchart.h
//  ZZBarchart
//
//  Created by songlu on 2017/3/3.
//  Copyright © 2017年 widget. All rights reserved.
//

#import "ZZBaseChart.h"
#import "ZZBar.h"
#import "ZZChartDelegate.h"
#import "ZZBaseChart.h"

@interface ZZBarchart : ZZBaseChart

@property (nonatomic, copy) void (^didClickBar)(ZZBar *bar);

@property (nonatomic, weak) id<ZZChartDelegate> delegate;

@property (nonatomic, strong) NSArray<id> *yValues;

@property (nonatomic, strong) NSArray *xLabels;
@property (nonatomic, strong) NSArray *yLabels;

/**
 set values ways:
 1,set just one of barMargin,barWidth,barWidths
 2,set barWidths and barMargin , it will adapt withs for suitable values
 */
@property (nonatomic, assign) CGFloat barMargin;
@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, strong) NSArray *barWidths;

@property (nonatomic, assign) CGFloat yMaxValue;
@property (nonatomic, assign) CGFloat yMinValue;
@property (nonatomic, assign) CGFloat yLabelWidth;
@property (nonatomic, assign) CGFloat yLabelHeight;
//@property (nonatomic, assign) CGFloat xLabelWidth;
@property (nonatomic, assign) CGFloat xLabelHeight;

@property (nonatomic, assign) NSInteger yLableNumber;

@property (nonatomic, strong) UIColor *xLableColor;
@property (nonatomic, strong) UIColor *ylableColor;
@property (nonatomic, strong) UIColor *chartBackgroundColor;


@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong) UIColor *detailLabelBackgroundColor;
@property (nonatomic, strong) UIColor *detailLabelTextColor;

@property (nonatomic, assign) BOOL showLeftLine;
@property (nonatomic, assign) BOOL showBottomLine;
@property (nonatomic, assign) BOOL showRightLine;
@property (nonatomic, assign) BOOL showXlabels;
@property (nonatomic, assign) BOOL showYlabels;
@property (nonatomic, assign) BOOL showDetailLabelOnBartop;
@property (nonatomic, assign) BOOL showDetailLabelOnBar;


/**
 待拓展,显示网格
 */
@property (nonatomic, assign) BOOL showGirds;//待拓展
@property (nonatomic, assign) BOOL showXGrids;//待拓展
@property (nonatomic, assign) BOOL showYGrids;//待拓展


/**
 待扩展,显示3D效果
 */
@property (nonatomic, assign) BOOL show3DModels;//待拓展

@property (nonatomic, copy)   NSString *yLableUnit;
@property (nonatomic, strong) NSArray *xStrokeColors;
@property (nonatomic, strong) NSArray *yStrokeColors;
@property (nonatomic, strong) UIColor *yStrokeColor;
@property (nonatomic, assign) UIEdgeInsets chartMargins;
@end
