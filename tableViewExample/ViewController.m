//
//  ViewController.m
//  tableViewExample
//
//  Created by on 2017/7/20.
//  Copyright © 2017年 9Fbank. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "UIView+convenience.h"


static const CGFloat MJDuration = 2.0;


#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.headerView.backgroundColor = [UIColor redColor];

    
    self.tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.tabView.backgroundColor = [UIColor greenColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 5, 50, 30);
    [button1 addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
    
    [button1 setTitle:@"tab1" forState:UIControlStateNormal];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(265, 5, 50, 30);
    button2.frameRight = SCREEN_WIDTH - 5;
    [button2 addTarget:self action:@selector(buttonAction2) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"tab2" forState:UIControlStateNormal];
    
    
    [self.tabView addSubview:button1];
    [self.tabView addSubview:button2];
    
    __weak __typeof(self) weakSelf = self;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
        });

        
    }];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellId"];
    [self.view addSubview:self.tableView];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tabView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}


- (void)buttonAction1{
    NSLog(@"buttonAction1");
}

- (void)buttonAction2{
    NSLog(@"buttonAction2");
}
@end
