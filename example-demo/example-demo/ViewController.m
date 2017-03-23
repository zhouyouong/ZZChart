//
//  ViewController.m
//  example-demo
//
//  Created by songlu on 2017/3/9.
//  Copyright © 2017年 ZZChart-master. All rights reserved.
//

#import "ViewController.h"
#import "ZZBarchart.h"

@interface ViewController ()<ZZChartDelegate>

@property (weak, nonatomic) IBOutlet UIView *conteinView;

@property (nonatomic, strong) ZZBarchart *barChart;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segementCL;

@property (weak, nonatomic) IBOutlet UISwitch *switchTop;
@property (weak, nonatomic) IBOutlet UISwitch *switchMiddle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self didSegmentSeleted:_segementCL];
}


- (IBAction)didSegmentSeleted:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    
    
    switch (index) {
        case 0:{
            [_barChart removeFromSuperview];
            _barChart = [[ZZBarchart alloc]initWithFrame:self.conteinView.frame];
            _barChart.showDetailLabelOnBar = self.switchMiddle.on;
            _barChart.showDetailLabelOnBartop = self.switchTop.on;
            [self.conteinView addSubview:_barChart];
            _barChart.yStrokeColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
            _barChart.xLabels = @[@1,@2,@3,@4,@5];
            _barChart.delegate = self;
            _barChart.yStrokeColor = [UIColor redColor];
            _barChart.barWidth = 40;
            _barChart.yValues =@[@10,@50,@70,@100,@50];
        }
            break;
        case 1:{
            [_barChart removeFromSuperview];
            _barChart = [[ZZBarchart alloc]initWithFrame:self.conteinView.frame];
            _barChart.showDetailLabelOnBar = self.switchMiddle.on;
            _barChart.showDetailLabelOnBartop = self.switchTop.on;
            [self.conteinView addSubview:_barChart];
            _barChart.yStrokeColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
            _barChart.xLabels = @[@1,@2,@3,@4,@5];
            _barChart.delegate = self;
            _barChart.yStrokeColor = [UIColor redColor];
            _barChart.barMargin = 40;
            _barChart.yValues =@[@10,@50,@200,@100,@50];
        }
            break;
        case 2:{
            [_barChart removeFromSuperview];
            _barChart = [[ZZBarchart alloc]initWithFrame:self.conteinView.frame];
            _barChart.showDetailLabelOnBar = self.switchMiddle.on;
            _barChart.showDetailLabelOnBartop = self.switchTop.on;
            [self.conteinView addSubview:_barChart];
            _barChart.yStrokeColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
            _barChart.xLabels = @[@1,@2,@3,@4,@5];
            _barChart.delegate = self;
            _barChart.barWidths =@[@20,@30,@20,@30,@20];
            _barChart.yValues =@[@10,@50,@70,@100,@50];
            
        }
            break;
        case 3:{
            
            [_barChart removeFromSuperview];
            _barChart = [[ZZBarchart alloc]initWithFrame:self.conteinView.frame];
            _barChart.showDetailLabelOnBar = self.switchMiddle.on;
            _barChart.showDetailLabelOnBartop = self.switchTop.on;
            [self.conteinView addSubview:_barChart];
            _barChart.yStrokeColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
            _barChart.xLabels = @[@1,@2,@3,@4,@5];
            _barChart.delegate = self;
            _barChart.barWidths =@[@20,@30,@20,@30,@20];
            _barChart.barMargin = 0;
            _barChart.yValues =@[@10,@50,@70,@100,@50];
            
        }
            break;
        case 4:{
            [_barChart removeFromSuperview];
            _barChart = [[ZZBarchart alloc]initWithFrame:self.conteinView.frame];
            _barChart.showDetailLabelOnBar = self.switchMiddle.on;
            _barChart.showDetailLabelOnBartop = self.switchTop.on;
            [self.conteinView addSubview:_barChart];
            _barChart.yStrokeColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
            _barChart.xLabels = @[@1,@2,@3,@4,@5];
            _barChart.delegate = self;
            _barChart.barMargin = 10;
            _barChart.yValues = @[@[@10,@20,@30],@[@20,@30,@40],@[@50,@20,@30],@[@40,@70,@20],@[@60,@20,@30]];
        }
            break;
        case 5:{
            [_barChart removeFromSuperview];
            _barChart = [[ZZBarchart alloc]initWithFrame:self.conteinView.frame];
            _barChart.showDetailLabelOnBar = self.switchMiddle.on;
            _barChart.showDetailLabelOnBartop = self.switchTop.on;
            [self.conteinView addSubview:_barChart];
            _barChart.yStrokeColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
            _barChart.xLabels = @[@1,@2,@3,@4,@5];
            _barChart.delegate = self;
            _barChart.barWidth = 10;
            _barChart.yValues = @[@[@10,@20,@30],@[@20,@30,@40],@[@50,@20,@30],@[@40,@70,@20],@[@60,@20,@30]];
            
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)detaileLabelDidSwitch:(UISwitch *)sender {
    if (sender.tag == 0 && sender.on) {
        self.switchMiddle.on = NO;
    }else if (sender.tag == 1&& sender.on){
        self.switchTop.on = NO;
    }
    [self didSegmentSeleted:self.segementCL];
}



-(void)userTouchIndex:(NSInteger)index{
    
    NSLog(@"%s  index:%zd", __FUNCTION__,index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
