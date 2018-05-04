//
//  PieChartViewController.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/3.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "PieChartViewController.h"
#import "SSWPieChartView.h"
@interface PieChartViewController ()

@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PieChartView";
   
}
-(void)viewDidLayoutSubviews{
     NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    SSWPieChartView   *pieChartView = [[SSWPieChartView alloc]initWithChartType:SSWChartsTypePie];
    pieChartView.bounds = CGRectMake(0, 0, 400, 400);
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    pieChartView.center = self.view.center;
    //标题数组与颜色数组个数应一致，如果标题数组过多，颜色数组自己可随机生成。
    pieChartView.colorsArr= @[[UIColor orangeColor],
                              [UIColor redColor],
                              [UIColor blueColor],
                              [UIColor grayColor],
                              [UIColor greenColor],
                              [UIColor blackColor],
                              [UIColor grayColor],
                              [UIColor darkGrayColor],
                              [UIColor grayColor],
                              [UIColor yellowColor]];//颜色数组
    pieChartView.titlesArr = @[@"小麦",
                               @"玉米",
                               @"大豆",
                               @"早籼稻",
                               @"旱籼稻",
                               @"小麦",
                               @"玉米",
                               @"大豆",
                               @"早籼稻",
                               @"旱籼稻"];//标题数组
    pieChartView.percentageArr = @[@"0.05",@"0.2",@"0.07",@"0.1",@"0.15",@"0.1",@"0.08",@"0.12",@"0.13"];
    //    pieChartView.radius = 50;
    [self.view addSubview:pieChartView];
}

@end
