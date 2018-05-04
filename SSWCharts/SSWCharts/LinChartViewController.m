//
//  LinChartViewController.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/3.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "LinChartViewController.h"
#import "SSWLineChartView.h"
@interface LinChartViewController ()

@end

@implementation LinChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LineChartView";
    self.view.backgroundColor = [UIColor lightGrayColor];
}
-(void)viewDidLayoutSubviews{
    SSWLineChartView   *barChartView = [[SSWLineChartView alloc]initWithChartType:SSWChartsTypeBar];
    barChartView.backgroundColor = [UIColor orangeColor];
    barChartView.xValuesArr = [@[@"小麦",@"玉米",@"早籼稻",@"旱籼稻",
                                 @"大豆",@"小豆",@"小米",@"大米",
                                 @"菜籽",@"芝麻",@"高粱",@"甘蔗",
                                 @"豌豆",@"红豆",@"绿豆",@"青稞"] mutableCopy];
    barChartView.yValuesArr = [@[@"100",@"200",@"300",
                                 @"60",@"460",@"368",
                                 @"235", @"222",@"100",
                                 @"200",@"300",@"500",
                                 @"136",@"366",@"350",
                                 @"450"] mutableCopy];
    barChartView.unit = @"吨";
    barChartView.yScaleValue=60;
    barChartView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 300);
    [self.view addSubview:barChartView];
}
@end
