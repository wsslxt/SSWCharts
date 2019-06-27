//
//  SSWLineChartView.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/3.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "SSWLineChartView.h"
@interface SSWLineChartView (){
    CGFloat         _totalWidth;
    CGFloat         _totalHeight;
    CAShapeLayer    *_AxiasLineLayer;
    CAShapeLayer    *_lineLayer;
}
@property(nonatomic)UIScrollView        *scrollView;
@property(nonatomic)UIView              *contentView;
@property(nonatomic)NSMutableArray      *barsStartPointsArr;
@property(nonatomic)NSMutableArray      *barsEndPointsArr;
@property(nonatomic)NSMutableArray      *linePointPathArr;
@property(nonatomic)NSMutableArray      *linePointLayerArr;
@property(nonatomic)UILabel             *unitLab;
@end
@implementation SSWLineChartView
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super initWithChartType:type];
    if (self) {
        [self setUp];
        
    }
    return self;
}
-(void)setUp{
    self.xValuesArr = [@[] mutableCopy];
    self.yValuesArr = [@[] mutableCopy];
    self.barsStartPointsArr  = [@[] mutableCopy];
    self.barsEndPointsArr = [@[] mutableCopy];
    self.linePointPathArr = [@[] mutableCopy];
    self.linePointLayerArr = [@[] mutableCopy];
    self.barWidth = 20;
    self.gapWidth = 20;
    self.yScaleValue = 50;
    self.yAxisCount = 10;
    self.showEachYValus=YES;
    self.lineColor = [UIColor greenColor];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.unitLab];
    [self addTap];
    [self.contentView addSubview:self.bubbleLab];
}
-(void)addTap{
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.contentView addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self.contentView];
    for (UIBezierPath *path in self.linePointPathArr) {
        if ([path containsPoint:point]) {
            NSInteger  index = [self.linePointPathArr indexOfObject:path];
            CGPoint  endPoint = [self.barsEndPointsArr[index] CGPointValue];
//            NSLog(@"点击了第%ld个柱形图",index);
//            self.bubbleLab.hidden=NO;
//            self.bubbleLab.text = self.yValuesArr[index];
//            self.bubbleLab.center = CGPointMake(endPoint.x, endPoint.y-10);
            if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectIndex:)]) {
                [self.delegate SSWChartView:self didSelectIndex:index];
            }
        }
}
}
-(void)setUnit:(NSString *)unit{
    _unit=unit;
    self.unitLab.text = [NSString stringWithFormat:@"单位:%@",unit];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.clipsToBounds=NO;
    }
    return _scrollView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        //        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}
-(UILabel *)unitLab{
    if (!_unitLab) {
        _unitLab = [[UILabel alloc]init];
        _unitLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    }
    return _unitLab;
}
-(void)layoutSubviews{
    self.scrollView.frame = self.bounds;
    self.unitLab.frame = CGRectMake(5, -10, 60, 20);
    _totalWidth= self.gapWidth+(self.barWidth+self.gapWidth)*self.xValuesArr.count;
    _totalHeight=self.scrollView.bounds.size.height-30-10;
    self.scrollView.contentSize = CGSizeMake(30+_totalWidth, 0);
    self.contentView.frame = CGRectMake(50,10, _totalWidth,_totalHeight);
    [self drawLineChart];
}
//开始绘制图表
-(void)drawLineChart{
    [self clear];
    [self drawAxis];
    [self addYAxisLabs];
    [self addXAxisLabs];
    [self calculationTheLinePoints];
    [self addLine];
    [self addLinePoints];
    [self showBarChartYValus];
}
//触发界面布局之前清除掉之前的绘制
-(void)clear{
    [self.barsStartPointsArr removeAllObjects];
    [self.barsEndPointsArr removeAllObjects];
    for (CAShapeLayer *layer in self.linePointLayerArr) {
        [layer removeFromSuperlayer];
    }
    [self.linePointLayerArr removeAllObjects];
    [_AxiasLineLayer removeFromSuperlayer];
    [_lineLayer removeFromSuperlayer];
    _AxiasLineLayer=nil;
    _lineLayer=nil;
    for (UIView *view in self.contentView.subviews) {
        if([view isEqual:self.unitLab])continue;
        [view removeFromSuperview];
    }
    
}
//画坐标轴
-(void)drawAxis{
    UIBezierPath   *path = [UIBezierPath bezierPath];
    //先画整体的线
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    //画左上角的箭头
    [path moveToPoint:CGPointMake(-5, 5)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(5, 5)];
    //画右上角的箭头
    [path moveToPoint:CGPointMake(_totalWidth-5, _totalHeight-5)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth-5, _totalHeight+5)];
    //画y轴刻度
    for (int i = 1; i<self.yAxisCount; i++) {
        [path moveToPoint:CGPointMake(0, i*(_totalHeight/self.yAxisCount))];
        [path addLineToPoint:CGPointMake(5, i*(_totalHeight/self.yAxisCount))];
    }
    //画x轴的刻度
    for (int i = 0; i<self.xValuesArr.count; i++) {
        CGPoint  startPoint = CGPointMake(i*(self.barWidth+self.gapWidth)+self.gapWidth+self.barWidth/2, _totalHeight);
        [self.barsStartPointsArr addObject:[NSValue valueWithCGPoint:startPoint]];
        [path moveToPoint:startPoint];
        [path addLineToPoint:CGPointMake(i*(self.barWidth+self.gapWidth)+self.gapWidth+self.barWidth/2, _totalHeight-5)];
    }
    
    CAShapeLayer   *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor grayColor].CGColor;
    lineLayer.lineWidth = 1;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    _AxiasLineLayer = lineLayer;
}
//给y轴添加刻度显示
-(void)addYAxisLabs{
    for (int i =self.yAxisCount ; i>0; i--) {
        CGFloat   yAxis = self.yScaleValue*i;
        UILabel  *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(-5, (self.yAxisCount-i)*(_totalHeight/self.yAxisCount)-10, -50, 20);
//        lab.backgroundColor = [UIColor whiteColor];
        lab.text = [NSString stringWithFormat:@"%.f",yAxis];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lab];
    }
}

//给x轴添加刻度显示
-(void)addXAxisLabs{
    for (int i = 0 ; i<self.xValuesArr.count; i++) {
        CGPoint   point = [self.barsStartPointsArr[i] CGPointValue];
        UILabel   *lab = [[UILabel alloc]init];
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth*4/5, 20);
        lab.center = CGPointMake(point.x, point.y+lab.bounds.size.height/2);
        lab.text = [NSString stringWithFormat:@"%@",self.xValuesArr[i]];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
    }
}
//计算折线的点坐标
-(void)calculationTheLinePoints{
    for (int i = 0 ; i<self.yValuesArr.count; i++) {
        CGFloat   Y = [(NSString *)self.yValuesArr[i] floatValue];
        CGFloat   barHeight = (Y/(self.yAxisCount*self.yScaleValue))*_totalHeight;
        CGPoint   startPoint = [self.barsStartPointsArr[i] CGPointValue];
        CGPoint   endPoint = CGPointMake(startPoint.x, startPoint.y-barHeight);
        [self.barsEndPointsArr addObject:[NSValue valueWithCGPoint:endPoint]];
    }
}
//添加折线的点
-(void)addLinePoints{
    for (int i = 0 ; i<self.xValuesArr.count; i++) {
        CGPoint   point = [self.barsEndPointsArr[i] CGPointValue];
        UIBezierPath   *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:point radius:5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
//        [path closePath];
        [self.linePointPathArr addObject:path];
        
        CAShapeLayer  *layer = [CAShapeLayer layer];
        layer.strokeColor = self.lineColor.CGColor;
        layer.fillColor = self.backgroundColor.CGColor;
        layer.lineWidth=1;
        layer.path = path.CGPath;
        [layer addAnimation:[self animationWithDuration:0.3*i] forKey:nil];
        [self.contentView.layer addSublayer:layer];
        [self.linePointLayerArr addObject:layer];
    }
}
//添加折线
-(void)addLine{
    UIBezierPath  *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:[self.barsEndPointsArr[0] CGPointValue]];
    for (int i = 1; i<self.barsEndPointsArr.count; i++) {
        [linePath addLineToPoint:[self.barsEndPointsArr[i] CGPointValue]];
    }
    
    CAShapeLayer  *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = self.lineColor.CGColor;
    lineLayer.lineWidth = 1;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.path = linePath.CGPath;
    [lineLayer addAnimation:[self animationWithDuration:0.3*self.barsEndPointsArr.count] forKey:nil];
    [self.contentView.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
}
//添加动画
-(CABasicAnimation *)animationWithDuration:(CFTimeInterval)duration{
    CABasicAnimation  *anmiation = [CABasicAnimation  animationWithKeyPath:@"strokeEnd"];
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmiation.duration =duration;
    anmiation.fromValue=@(0);
    anmiation.toValue = @(1);
    return anmiation;
}
//显示每个柱形图的值
-(void)showBarChartYValus{
    if(!self.showEachYValus)return;
    for (int i = 0; i<self.xValuesArr.count; i++) {
        CGPoint  point = [self.barsEndPointsArr[i] CGPointValue];
        UILabel  *lab = [[UILabel alloc]init];
        lab.textColor = self.lineColor;
        lab.font = [UIFont systemFontOfSize:10];
        lab.text = self.yValuesArr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth*4/5, 20);
        lab.center = CGPointMake(point.x, point.y-10);
        [self.contentView addSubview:lab];
    }
}
@end
