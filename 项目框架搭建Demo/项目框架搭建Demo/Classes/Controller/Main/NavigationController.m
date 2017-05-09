//
//  NavigationController.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "NavigationController.h"
#import "BaseViewController.h"

@interface NavigationController ()

@end

@implementation NavigationController
#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏默认 navigationBar
    self.navigationBar.hidden = YES;
}

#pragma mark --- pop 到父控制器
- (void)popToParent {
    [self popViewControllerAnimated:YES];
}

#pragma mark --- 重写 push 方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 根控制器不作处理
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        if ([viewController isKindOfClass:[BaseViewController class]]) {
            NSString *title = @"返回";
            if (self.childViewControllers.count == 1) {
                title = ((BaseViewController *)[self.childViewControllers firstObject]).navItem.title ? ((BaseViewController *)[self.childViewControllers firstObject]).navItem.title : @"返回";
            }
            ((BaseViewController *)viewController).navItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:title target:self action:@selector(popToParent) isBack:YES];
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
