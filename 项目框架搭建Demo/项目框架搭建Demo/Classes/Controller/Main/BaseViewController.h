//
//  BaseViewController.h
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

/// 用户登录标记
@property (nonatomic, assign) BOOL userLogin;

/// 自定义 navItem
@property (nonatomic, strong) UINavigationItem *navItem;

/// 表格视图
@property (nonatomic, strong) UITableView *tableView;

/// 刷新控件
@property (nonatomic, strong) UIRefreshControl *refreshControl;

/// 上拉刷新标记
@property (nonatomic, assign) BOOL isPullup;

/// 访客视图信息字典
@property (nonatomic, strong) NSDictionary *infoDict;

- (void)setupTableView;

- (void)loadData;

@end
