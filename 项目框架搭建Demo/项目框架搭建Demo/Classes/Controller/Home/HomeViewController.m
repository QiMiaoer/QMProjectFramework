//
//  HomeViewController.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "HomeViewController.h"
#import "TestViewController.h"

#define CellID @"cellid"

@interface HomeViewController ()
/// 表格数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomeViewController
#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark --- 加载数据
- (void)loadData {
    [self.refreshControl beginRefreshing];
    // 模拟延时加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i<10; i++) {
            if (self.isPullup) {
                [self.dataSource addObject:[NSString stringWithFormat:@"up %d", i]];
            } else {
                [self.dataSource insertObject:[NSString stringWithFormat:@"down %d", i] atIndex:0];
            }
        }
        // 刷新结束，重新刷新表格
        self.isPullup = NO;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark --- leftItem 点击事件
- (void)leftItemAction {
    TestViewController *TVC = [TestViewController new];
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark --- 设置界面
- (void)setupTableView {
    [super setupTableView];
    
    self.navItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"好友" target:self action:@selector(leftItemAction) isBack:NO];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
}

#pragma mark --- 数据源懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
