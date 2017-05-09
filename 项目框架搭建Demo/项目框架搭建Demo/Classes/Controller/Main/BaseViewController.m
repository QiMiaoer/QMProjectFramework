//
//  BaseViewController.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "BaseViewController.h"
#import "VisitorView.h"

@interface BaseViewController ()
/// 自定义 navigationBar
@property (nonatomic, strong) UINavigationBar *navigationBar;
/// 访客视图
@property (nonatomic, strong) VisitorView *visitorView;

@end

@implementation BaseViewController
#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self loadData];
}

#pragma mark --- 加载数据
- (void)loadData {
    [self.refreshControl endRefreshing];
}

#pragma mark --- 登陆、注册点击事件
- (void)loginAction {
    NSLog(@"用户登录");
    self.userLogin = YES;
    self.navItem.leftBarButtonItem = nil;
    self.navItem.rightBarButtonItem = nil;
    self.view = nil; // 会调用 viewDidLoad
}
- (void)registerAction {
    NSLog(@"用户注册");
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 分区总行数
    NSInteger count = [tableView numberOfRowsInSection:indexPath.section];
    // 判断是最后一行，并且还没有开始上拉刷新
    if (indexPath.row==count-1 && !self.isPullup) {
        // 修改标记，加载数据
        self.isPullup = YES;
        [self loadData];
    }
}

#pragma mark --- 设置界面
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    /// 取消自动缩进 如果隐藏了导航栏，会缩进20
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.navigationBar];
    self.userLogin ? [self setupTableView] : [self setupVisitorView];
}

#pragma mark --- 设置 tableView
- (void)setupTableView {
    [self.view insertSubview:self.tableView belowSubview:self.navigationBar];
}

#pragma mark --- 设置 visitorView
- (void)setupVisitorView {
    [self.view insertSubview:self.visitorView belowSubview:self.navigationBar];
}

#pragma mark --- navigationBar 懒加载
- (UINavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        // 设置 bar 背景色
        _navigationBar.barTintColor = [UIColor whiteColor];
        // 系统按钮文字颜色
        _navigationBar.tintColor = kRGB16(0xdbb058);
        // 设置 bar title 颜色
        _navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        _navigationBar.items = @[self.navItem];
    }
    return _navigationBar;
}

#pragma mark --- navItem 懒加载
- (UINavigationItem *)navItem {
    if (!_navItem) {
        _navItem = [UINavigationItem new];
    }
    return _navItem;
}

#pragma mark --- tableView 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // 设置内容缩进
        _tableView.contentInset = UIEdgeInsetsMake(self.navigationBar.bounds.size.height, 0, self.tabBarController.tabBar.bounds.size.height, 0);
        // 添加刷新控件
        [_tableView addSubview:self.refreshControl];
    }
    return _tableView;
}

#pragma mark --- 访客视图 懒加载
- (VisitorView *)visitorView {
    if (!_visitorView) {
        _visitorView = [[VisitorView alloc] initWithFrame:self.view.bounds];
        _visitorView.infoDict = self.infoDict;
        [_visitorView.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        self.navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
        self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
    }
    return _visitorView;
}

#pragma mark --- 刷新控件 懒加载
- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

@end
