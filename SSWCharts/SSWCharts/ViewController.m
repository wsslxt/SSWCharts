//
//  ViewController.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "ViewController.h"
#import "PieChartViewController.h"
#import "BarChartViewController.h"
#import "LinChartViewController.h"
#import "MutipleBarChartViewController.h"
#import "MutipleLineChartViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray       *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = [@[] mutableCopy];
     self.dataArr = [@[@"PieChartViewController",
                      @"BarChartViewController",
                      @"LinChartViewController",
                      @"MutipleBarChartViewController",
                      @"MutipleLineChartViewController"] mutableCopy];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString  *className =self.dataArr[indexPath.row];
    UIViewController  *vc = [NSClassFromString(className) alloc];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
