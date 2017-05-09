//
//  TestViewController.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController
#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark --- rightItem 点击事件
- (void)showNext {
    TestViewController *TVC = [TestViewController new];
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark --- 设置界面
- (void)setupTableView {
    [super setupTableView];
    
    self.navItem.title = [NSString stringWithFormat:@"第%ld个", self.navigationController.childViewControllers.count];
    self.view.backgroundColor = kRandomColor;
    
    self.navItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"下一个" target:self action:@selector(showNext) isBack:NO];
}

@end
