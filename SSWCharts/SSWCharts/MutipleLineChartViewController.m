//
//  MutipleLineChartViewController.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/7.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "MutipleLineChartViewController.h"
#import "SSWMutipleLineChart.h"
@interface MutipleLineChartViewController ()<SSWChartsDelegate>

@end

@implementation MutipleLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"mutipleLineChartView";
}
-(void)SSWChartView:(SSWCharts *)chartView didSelectMutipleBarChartIndex:(NSArray *)index{
         NSLog(@"点击了(%d,%d)",[index[0] intValue],[index[1] intValue]);
}
-(void)viewDidLayoutSubviews{
    SSWMutipleLineChart   *mutipleLineChartView = [[SSWMutipleLineChart alloc]initWithChartType:SSWChartsTypeBar];
    mutipleLineChartView.backgroundColor = [UIColor orangeColor];
    mutipleLineChartView.xValuesArr = [@[@"2015",@"2016",@"2018",@"2019",
                                        @"2020",@"2021",@"2022",@"2023",
                                         @"2024",@"2025",@"2026",@"2027"] mutableCopy];
    mutipleLineChartView.yValuesArr = [@[@[@"200",@"90",@"150"],
                                         @[@"80",@"210",@"250"],
                                         @[@"100",@"200",@"300"],
                                         @[@"200",@"150",@"30"],
                                         @[@"70",@"50",@"335"],
                                         @[@"90",@"200",@"220"],
                                         @[@"190",@"200",@"170"],
                                         @[@"160",@"450",@"235"],
                                         @[@"150",@"330",@"368"],
                                         @[@"160",@"222",@"258"],
                                         @[@"100",@"198",@"263"],
                                         @[@"170",@"192",@"356"],] mutableCopy];
    mutipleLineChartView.legendTitlesArr =[ @[@"小麦",@"玉米",@"大豆"] mutableCopy];
    mutipleLineChartView.unit = @"吨";
    mutipleLineChartView.delegate = self;
    //    barChartView.yScaleValue=60;
    mutipleLineChartView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 300);
    mutipleLineChartView.barColorArr = [@[[UIColor greenColor],[UIColor blueColor],[UIColor redColor]] mutableCopy];
    [self.view addSubview:mutipleLineChartView];
}
@end
