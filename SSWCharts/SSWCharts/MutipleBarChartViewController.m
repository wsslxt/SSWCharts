//
//  MutipleBarChartViewController.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/7.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "MutipleBarChartViewController.h"
#import "SSWMutipleBarChartView.h"
@interface MutipleBarChartViewController ()<SSWChartsDelegate>

@end

@implementation MutipleBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"mutipleBarChartView";
}
-(void)viewDidLayoutSubviews{
    SSWMutipleBarChartView   *mutipleBarChartView = [[SSWMutipleBarChartView alloc]initWithChartType:SSWChartsTypeBar];
    mutipleBarChartView.backgroundColor = [UIColor orangeColor];
    mutipleBarChartView.xValuesArr = [@[@"2015",@"2016",@"2018",@"2019",
                                 @"2020",@"2021",@"2022"] mutableCopy];
    mutipleBarChartView.yValuesArr = [@[@[@"100",@"200",@"300"],
                                 @[@"80",@"210",@"150"],
                                 @[@"100",@"200",@"300"],
                                 @[@"100",@"200",@"300"],
                                 @[@"100",@"200",@"300"],
                                 @[@"100",@"200",@"300"],
                                 @[@"100",@"200",@"300"]] mutableCopy];
    mutipleBarChartView.unit = @"吨";
    mutipleBarChartView.delegate = self;
    mutipleBarChartView.legendTitlesArr = @[@"小麦",@"玉米",@"大豆"];
//    barChartView.yScaleValue=60;
    mutipleBarChartView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 300);
    mutipleBarChartView.barColorArr = [@[[UIColor greenColor],[UIColor blueColor],[UIColor redColor]] mutableCopy];
    [self.view addSubview:mutipleBarChartView];
}
-(void)SSWChartView:(SSWCharts *)chartView didSelectMutipleBarChartIndex:(NSArray *)index{
    NSLog(@"点击的是(%d,%d)",[index[0] intValue],[index[1] intValue]);
}
@end
