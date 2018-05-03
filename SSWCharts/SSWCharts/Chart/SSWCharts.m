//
//  SSWCharts.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "SSWCharts.h"

@implementation SSWCharts
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super init];
    if (self) {
        self.chartType = type;
    }
    return self;
}
-(UILabel *)bubbleLab{
    if (!_bubbleLab) {
        _bubbleLab = [[UILabel  alloc]init];
        _bubbleLab.bounds = CGRectMake(0, 0, 60, 20);
        _bubbleLab.textAlignment = NSTextAlignmentCenter;
        _bubbleLab.textColor = [UIColor whiteColor];
//        _bubbleLab.backgroundColor = [UIColor blueColor];
        _bubbleLab.hidden=YES;
        _bubbleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    }
    return _bubbleLab;
}
@end
