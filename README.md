# SSWCharts
SSWChart 是一款快速集成到项目中的图表框架，其中包含饼状图、条形图、和折线图。界面展示如下：

柱形图的使用方法:
SSWBarChartView   *barChartView = [[SSWBarChartView alloc]initWithChartType:SSWChartsTypeBar];
barChartView.backgroundColor = [UIColor orangeColor];
barChartView.xValuesArr = [@[@"小麦",@"玉米",@"早籼稻",@"旱籼稻",
                                 @"大豆",@"小豆",@"小米",@"大米",
                                 @"菜籽",@"芝麻",@"高粱",@"甘蔗",
                                 @"豌豆",@"红豆",@"绿豆",@"青稞"] mutableCopy];
barChartView.yValuesArr = [@[@"100",@"200",@"300",@"60",
                                 @"460",@"368",@"235",@"222",
                                 @"100",@"200",@"300",@"500",
                                 @"136",@"366",@"350",@"450"] mutableCopy];
barChartView.unit = @"吨";
barChartView.yScaleValue=60;
barChartView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 300);
[self.view addSubview:barChartView];
![柱形图](https://raw.githubusercontent.com/wsslxt/SSWCharts/master/images/barChart.png)
折线图![折线图](https://raw.githubusercontent.com/wsslxt/SSWCharts/master/images/lineChart.png)
饼状图![饼状图](https://raw.githubusercontent.com/wsslxt/SSWCharts/master/images/pieChart.png)
mutipleBarChart![mutipleBarChart](https://raw.githubusercontent.com/wsslxt/SSWCharts/master/images/mutipleBar.png)
mutipleLineChart![mutipleLineChart](https://raw.githubusercontent.com/wsslxt/SSWCharts/master/images/mutipleLine.png)
