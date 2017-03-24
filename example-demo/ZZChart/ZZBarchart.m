//
//  ZZBarchart.m
//  ZZBarchart
//
//  Created by songlu on 2017/3/3.
//  Copyright © 2017年 widget. All rights reserved.
//

#import "ZZBarchart.h"
#import "ZZLabel.h"

@interface ZZBarchart (){

    BOOL _isMutiBar;
    NSInteger _ySegmentCount;
    NSMutableArray *_xBarLabels;
    NSMutableArray *_yBarLabels;
    NSMutableArray *_temproryArr;
    CGFloat _yValueMax;
    CGFloat _yValueMin;
    CAShapeLayer *_leftLine;
    CAShapeLayer *_bottonLine;
    CAShapeLayer *_rightLine;
    CGFloat _xHeightLabel;
//    CGFloat _xWidthLable;
    CGFloat _yHeightLabel;
    CGFloat _yWidthLabel;
    CGFloat _marginBar;
    CGFloat _widthBar;
    CGFloat _conteinerHeight;
    CGFloat _conteinerWidth;
    NSMutableArray * _barsConteiner;
    NSMutableArray * _labelsConteiner;
    BOOL _didSetBarmagin;
}

@end

@implementation ZZBarchart

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetUP];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultSetUP];
    }
    return self;
}

-(void)defaultSetUP{
    
    _xLableColor = [UIColor blackColor];
    _ylableColor = [UIColor blackColor];
    _chartBackgroundColor = [UIColor clearColor];
    _showLeftLine = YES;
    _showRightLine = YES;
    _showBottomLine = YES;
    _showYlabels = YES;
    _showXlabels = YES;
    _isMutiBar = NO;
    _showDetailLabelOnBartop = YES;
    _showDetailLabelOnBar = NO;
    _chartMargins = UIEdgeInsetsMake(25, 10, 20, 18);
    _xBarLabels = [NSMutableArray array];
    _yBarLabels = [NSMutableArray array];
    _temproryArr = [NSMutableArray array];
    _barsConteiner = [NSMutableArray array];
    _labelsConteiner = [NSMutableArray array];
    _ySegmentCount = 1;
    _yLableNumber = 0;
    _yValueMin = 0;
    _xHeightLabel = 18;
    _yHeightLabel = 0;
    _yWidthLabel = 33;
    _marginBar  = 5;
}

-(void)setYValues:(NSArray *)yValues{
    _yValues = yValues;
    [self checkyValuesItem:yValues];
}

-(void)checkyValuesItem:(NSArray *)yValues{
    for (id obj in yValues) {
        if ([obj isKindOfClass:[NSArray class]] ) {
            _isMutiBar = YES;
            _ySegmentCount = ((NSMutableArray*)obj).count;
        }
        if ([obj isKindOfClass:[NSMutableArray class]]) {
            _isMutiBar = YES;
            _ySegmentCount = ((NSMutableArray*)obj).count;
        }
    }
    [self dealWithyValues:yValues];
}

-(void)dealWithyValues:(NSArray *)yValues{

    if (_yMaxValue) {
        _yValueMax = _yMaxValue;
    }else{
        _yValueMax = [self getMaxValueWith:yValues];
    }
    
    if (_yMinValue) {
        _yValueMin = _yMinValue;
    }
    if (_showYlabels) {
        if (_yLableNumber == 0) {
            if (_yLabels) {
                _yLableNumber = _yLabels.count;
            }else{
                _yLableNumber = 5;
            }
            [self createYlablesWithUserDefineYlables:NO];
        }else{
            [self createYlablesWithUserDefineYlables:YES];
        }
    }
 
}

-(CGFloat)getMaxValueWith:(NSArray *)values{

    if (_isMutiBar) {
        
        for (NSArray * conetentArr in values) {
            CGFloat contentvalue = 0;
            for (int i = 0; i < conetentArr.count; ++i) {
                id obj = conetentArr[i];
                contentvalue += [obj floatValue];
            }
            [_temproryArr addObject:@(contentvalue)];
        }
        return [[_temproryArr valueForKeyPath:@"@max.floatValue"] floatValue];
    }else{
        return [[values valueForKeyPath:@"@max.floatValue"] floatValue];
    }

}

-(void)createYlablesWithUserDefineYlables:(BOOL)usersyLables{
    [self viewsRemoveForCollectionView:_yBarLabels];

    CGFloat totalH = self.frame.size.height;
    _conteinerHeight = totalH - _chartMargins.top - _chartMargins.bottom-_xHeightLabel;
    _conteinerWidth = self.frame.size.width-_yWidthLabel-_chartMargins.left-_chartMargins.right;
    for (int i = 0; i < _yLableNumber; ++i) {
        
        CGFloat labelH =(totalH - _chartMargins.top - _chartMargins.bottom-_xHeightLabel)/_yLableNumber;
        
        CGFloat labelW = _yWidthLabel;
        CGFloat labelX = _chartMargins.left;
        CGFloat labelY = totalH - _chartMargins.bottom -_xHeightLabel - labelH*(i+1.5);
        
        ZZLabel * ylable = [[ZZLabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//        ylable.textAlignment = NSTextAlignmentRight;
        if (usersyLables) {
           ylable.text = [NSString stringWithFormat:@"%@",_yLabels[i]];
        }else{
          ylable.text = [NSString stringWithFormat:@"%.f",_yValueMax/_yLableNumber*(i+1)];
        }
        
        if (_ylableColor) {
            ylable.textColor = _ylableColor;
        }else{
            ylable.textColor = [UIColor whiteColor];
        }
        ylable.backgroundColor = [UIColor clearColor];
        [self addSubview:ylable];
        [_yBarLabels addObject:ylable];
    }
    
    [self drawChart];
}

-(void)drawChart{

    [self viewsRemoveForCollectionView:_barsConteiner];
    [self viewsRemoveForCollectionView:_xBarLabels];
    [self drawLins];
    [self drawBars];
}

-(void)drawLins{

    if (_showLeftLine) {
        _leftLine = [[CAShapeLayer alloc]init];
        _leftLine.fillColor = [UIColor clearColor].CGColor;
        if (_lineColor) {
            _leftLine.strokeColor = _lineColor.CGColor;
        }else{
            _leftLine.strokeColor = [UIColor blackColor].CGColor;
        }
        _leftLine.lineCap = kCALineCapButt;
        _leftLine.lineWidth = 1.0;
        _leftLine.strokeEnd = 0.0;
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        path.lineWidth = 1.0;
        path.lineCapStyle = kCGLineCapSquare;
        [path moveToPoint:CGPointMake(_chartMargins.left+_yWidthLabel, self.frame.size.height - _xHeightLabel -_chartMargins.bottom)];
        [path addLineToPoint:CGPointMake(_chartMargins.left+_yWidthLabel, _chartMargins.top)];
        
        _leftLine.path = path.CGPath;
        
        [self.layer addSublayer:_leftLine];
        [self addLineAnimation];
    }
    
    if (_showBottomLine) {
        _bottonLine = [[CAShapeLayer alloc]init];
        _bottonLine.fillColor = [UIColor clearColor].CGColor;
        if (_lineColor) {
            _bottonLine.strokeColor = _lineColor.CGColor;
        }else{
            _bottonLine.strokeColor = [UIColor blackColor].CGColor;
        }
        _bottonLine.lineCap = kCALineCapButt;
        _bottonLine.lineWidth = 1.0;
        _bottonLine.strokeEnd = 0.0;
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        path.lineWidth = 1.0;
        path.lineCapStyle = kCGLineCapSquare;
        [path moveToPoint:CGPointMake(_chartMargins.left+_yWidthLabel, self.frame.size.height - _xHeightLabel -_chartMargins.bottom)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - _chartMargins.right, self.frame.size.height - _xHeightLabel -_chartMargins.bottom)];
        
        _bottonLine.path = path.CGPath;
        
        [self.layer addSublayer:_bottonLine];
        [self addLineAnimation];
    }

    if (_showRightLine) {
        _rightLine = [[CAShapeLayer alloc]init];
        _rightLine.fillColor = [UIColor clearColor].CGColor;
        if (_lineColor) {
            _rightLine.strokeColor = _lineColor.CGColor;
        }else{
            _rightLine.strokeColor = [UIColor blackColor].CGColor;
        }
        _rightLine.lineCap = kCALineCapButt;
        _rightLine.lineWidth = 1.0;
        _rightLine.strokeEnd = 0.0;
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        path.lineWidth = 1.0;
        path.lineCapStyle = kCGLineCapSquare;
        [path moveToPoint:CGPointMake(self.frame.size.width - _chartMargins.right, self.frame.size.height - _xHeightLabel -_chartMargins.bottom)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - _chartMargins.right, _chartMargins.top)];
        
        _rightLine.path = path.CGPath;
        
        [self.layer addSublayer:_rightLine];
        [self addLineAnimation];
    }
}

-(void)addLineAnimation{

    if (self.playAniamtion) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 0.5;
        animation.fromValue = @0.0f;
        animation.toValue = @1.0f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (_showLeftLine) {
            [_leftLine addAnimation:animation forKey:@"animation"];
            _leftLine.strokeEnd = 1.0;
        }
        if (_showBottomLine) {
            [_bottonLine addAnimation:animation forKey:@"animation"];
            _bottonLine.strokeEnd = 1.0;
        }
        if (_showRightLine) {
            [_rightLine addAnimation:animation forKey:@"animation"];
            _rightLine.strokeEnd = 1.0;
        }
    }else{
        _leftLine.strokeEnd = 1.0;
        _bottonLine.strokeEnd = 1.0;
        _rightLine.strokeEnd = 1.0;
    }
}


-(void)drawBars{
    
    CGFloat totalH = self.frame.size.height;
    
    if (!_barMargin &&(_barWidth || _barWidths)){//only set bar width or bar widths

        if (!_barWidths) {
            _marginBar = (_conteinerWidth - _yValues.count*_widthBar)/(_yValues.count-1);
        }else{
            CGFloat sum = 0;
            for (id obj in _barWidths) {
                sum += [obj floatValue];
            }
            _marginBar = (_conteinerWidth - sum)/(_yValues.count-1);
        }
        
    }else{//other conditions

        _barWidth = (_conteinerWidth-(_yValues.count-1)*_marginBar)/_yValues.count;
    }
    
    CGFloat totalW = 0;
    CGFloat pertenage = 1;
    if (_barWidths) {
        for (id obj in _barWidths) {
            totalW += [obj floatValue];
        }
        pertenage = (_conteinerWidth - (_barWidths.count-1)*_barMargin)/totalW;
    }
    
    if (_isMutiBar) {
        
        CGFloat widths = 0;
        for (int i = 0; i < _yValues.count; ++i) {
            
            NSArray * subArr = _yValues[i];
            
            CGFloat barW;
            CGFloat barX;
            
            if (!_barWidths) {
                barW = _barWidth;
                barX = _chartMargins.left + _yWidthLabel +i*(_barWidth +_marginBar);
            }else{
                barW = [_barWidths[i] floatValue];
                barX = _chartMargins.left + _yWidthLabel +i*_marginBar + widths;
                
                if (_barWidths && _didSetBarmagin) {
                    _marginBar = _barMargin;
                    barW = barW*pertenage;
                    barX = _chartMargins.left + _yWidthLabel +i*_marginBar + widths;
                }
                widths += barW;
            }
            
            
            CGFloat barY = totalH -_chartMargins.bottom-_xHeightLabel;
            
            CGFloat barH;
        
            [self creareXlabelsWith:CGRectMake(barX, barY, barW, _xHeightLabel) andIndex:i];
            
            for (int j = 0; j < subArr.count; ++j) {
                
                barH = [subArr[j] floatValue];
                
                if (_yValueMax != 0) {
                    barH = barH/_yValueMax*_conteinerHeight;
                }else{
                    barH = 0;
                }
                barY -= barH;
                
                ZZBar * subbar = [[ZZBar alloc]initWithFrame:CGRectMake(barX, barY, barW, barH)];
            
                if (_yStrokeColors[j]) {
                    [UIView animateWithDuration:1.5 animations:^{
                        subbar.backgroundColor = _yStrokeColors[j];
                    }];
                    
                }else{
                    
                    [UIView animateWithDuration:1.5 animations:^{
                        subbar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3*j];
                    }];
                }
                subbar.tag = i*_yValues.count*10000 +j;
                subbar.displayAnimation = self.playAniamtion;
                [self addSubview:subbar];
                [_barsConteiner addObject:subbar];
                
            }
        }
        
    }else{
        
        ZZBar * bar;
        CGFloat widths = 0;
        for (int i = 0; i < _yValues.count; ++i) {
            if (_barsConteiner.count == _yValues.count) {
                bar = [_barsConteiner objectAtIndex:i];
            }else{

                CGFloat barW;
                CGFloat barX;
                
                if (!_barWidths) {
                    barW = _barWidth;
                    barX = _chartMargins.left + _yWidthLabel +i*(_barWidth +_marginBar);
                }else{
                    barW = [_barWidths[i] floatValue];
                    barX = _chartMargins.left + _yWidthLabel +i*_marginBar + widths;
                    
                    if (_barWidths && _didSetBarmagin) {
                        _marginBar = _barMargin;
                        barW = barW*pertenage;
                        barX = _chartMargins.left + _yWidthLabel +i*_marginBar + widths;
                    }
                    widths += barW;
                }
                
                CGFloat barY = totalH -_chartMargins.bottom-_xHeightLabel;
                
                CGFloat barH = [_yValues[i] floatValue];
                if (_yValueMax != 0) {
                    barH = barH/_yValueMax*_conteinerHeight;
                }else{
                    barH = 0;
                }
                
                
                bar = [[ZZBar alloc]initWithFrame:CGRectMake(barX, barY, barW, -barH)];
                
                [self creareXlabelsWith:CGRectMake(barX, barY, barW, _xHeightLabel) andIndex:i];
                if (_yStrokeColor) {
                    [UIView animateWithDuration:1.5 animations:^{
                       bar.backgroundColor = _yStrokeColor;
                    }];
                }else{
                    [UIView animateWithDuration:1.5 animations:^{
                        bar.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
                    }];
                }
                bar.tag = i;
                bar.displayAnimation = self.playAniamtion;
                [self addSubview:bar];
                [_barsConteiner addObject:bar];
            }
        }
    
    }
    
    [self addAnimationToBars];
    
}




-(void)addAnimationToBars{
    
    for (ZZBar * bar in _barsConteiner) {
        CGRect rect = bar.frame;
        CGFloat rectX = rect.origin.x;
        CGFloat rectY = rect.origin.y;
        CGFloat rectW = rect.size.width;
//        CGFloat rectH = rect.size.height;
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.duration = 0.5;
        animation.repeatCount =1;
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(rectX, rectY, rectW, 0)];
        animation.toValue = [NSValue valueWithCGRect:rect];
        [bar.layer addAnimation:animation forKey:nil];
    }
}

-(void)creareXlabelsWith:(CGRect)rect andIndex:(NSInteger)index{    

    if (_showXlabels && _xLabels) {
        ZZLabel * xlabel = [[ZZLabel alloc]initWithFrame:rect];
        xlabel.textAlignment = NSTextAlignmentCenter;
        if (_xLableColor) {
            xlabel.textColor = _xLableColor;
        }else{
            xlabel.textColor = [UIColor blackColor];
        }
        if (_xLabels[index]) {
            xlabel.text = [NSString stringWithFormat:@"%@",_xLabels[index]];
        }
        xlabel.backgroundColor = [UIColor clearColor];
        [self addSubview:xlabel];
        [_xBarLabels addObject:xlabel];
    }
}

-(void)viewsRemoveForCollectionView:(NSMutableArray *)lables{
    if (lables.count) {
        [lables makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [lables removeAllObjects];
    }
}

#pragma mark - Touch events

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self touches:touches Envents:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self touches:touches Envents:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self viewsRemoveForCollectionView:_labelsConteiner];
}

-(void)touches:(NSSet *)touches Envents:(UIEvent *)event{
    UITouch * touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    UIView * subView = [self hitTest:point withEvent:event];
    
    
    if (self.didClickBar && [subView isKindOfClass:[ZZBar class]]) {
        self.didClickBar((ZZBar *)subView);
    }
    
    if ([self.delegate respondsToSelector:@selector(userTouchIndex:)]&& [subView isKindOfClass:[ZZBar class]]) {
        [self.delegate userTouchIndex:subView.tag];
        [self drawDetailLabelOnBar:(ZZBar*)subView];
    }
}

-(void)drawDetailLabelOnBar:(ZZBar*)bar{
    [self viewsRemoveForCollectionView:_labelsConteiner];
    CGRect rect = bar.frame;
    CGFloat labelX = rect.origin.x;
    CGFloat labelY = rect.origin.y+rect.size.height/2.0;
    CGFloat labelW = 100;
    CGFloat labelH = 22;
    NSString * title;
    if (_isMutiBar) {
        NSArray * sub = _yValues[bar.tag/(_yValues.count*10000)];
        title = [NSString stringWithFormat:@"%@",sub[bar.tag%(_yValues.count*10000)]];
    }else{
        title = [NSString stringWithFormat:@"%@",_yValues[bar.tag]];
    }
    
    UILabel * titleLabel = [[UILabel alloc]init];
    if (_showDetailLabelOnBartop) {
        titleLabel.frame =CGRectMake(labelX-50+rect.size.width/2.0, labelY-rect.size.height/2.0-22, labelW, labelH);
    }else if (_showDetailLabelOnBar){
        titleLabel.frame =CGRectMake(labelX-50+rect.size.width/2.0, labelY-11, labelW, labelH);
    }
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if (self.detailLabelTextColor) {
        titleLabel.textColor = self.detailLabelTextColor;
    }
    if (self.detailLabelBackgroundColor) {
        titleLabel.backgroundColor = self.detailLabelBackgroundColor;
    }
    [self addSubview:titleLabel];
    [_labelsConteiner addObject:titleLabel];
}


-(void)setBarMargin:(CGFloat)barMargin{
    _barMargin = barMargin;
    _marginBar = barMargin;
    _didSetBarmagin = YES;
}

-(void)setBarWidth:(CGFloat)barWidth{
    _barWidth = barWidth;
    _widthBar = barWidth;
}

-(void)setXLabelHeight:(CGFloat)xLabelHeight{
    _xLabelHeight = xLabelHeight;
    _xHeightLabel = xLabelHeight;
}

//-(void)setXLabelWidth:(CGFloat)xLabelWidth{
//    _xLabelWidth = xLabelWidth;
//    _xWidthLable = xLabelWidth;
//}

-(void)setYLabelWidth:(CGFloat)yLabelWidth{
    _yLabelWidth = yLabelWidth;
    _yWidthLabel = yLabelWidth;
}

-(void)setYLabelHeight:(CGFloat)yLabelHeight{
    _yLabelHeight = yLabelHeight;
    _yHeightLabel = yLabelHeight;
}

@end
