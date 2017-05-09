//
//  MainViewController.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationController.h"
#import "BaseViewController.h"

@interface MainViewController ()
/// 加号按钮
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation MainViewController
#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildControllers];
    [self setupAddButton];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark --- 加号按钮点击事件
- (void)addButtonAction:(UIButton *)sender {
    NSLog(@"click add button !!!");
    
    // 测试方向选择
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark --- 设置加号按钮
- (void)setupAddButton {
    [self.tabBar addSubview:self.addButton];
    
    CGFloat itemWidth = self.tabBar.bounds.size.width / self.childViewControllers.count;
    self.addButton.frame = CGRectMake(itemWidth * 2, 0, itemWidth, self.tabBar.frame.size.height);
}

#pragma mark --- 设置子控制器
- (void)setupChildControllers {
//    NSArray *array = @[@{@"clsName": @"HomeViewController", @"title": @"首页", @"imageName":@"homepage", @"visitorInfo": @{@"text":@"首页访客视图"          , @"imageName":@"homepage", @"rotateImageName": @"homepage_selected"}},
//                       @{@"clsName": @"MessageViewController", @"title": @"消息", @"imageName":@"message", @"visitorInfo": @{@"text":@"消息访客视图", @"imageName":@"message", @"rotateImageName": @"message_selected"}},
//                       @{@"clsName": @"UIViewController"},
//                       @{@"clsName": @"DiscorverViewController", @"title": @"发现", @"imageName":@"discover", @"visitorInfo": @{@"text":@"发现访客视图", @"imageName":@"discover", @"rotateImageName": @"discover_selected"}},
//                       @{@"clsName": @"ProfileViewController", @"title": @"我的", @"imageName":@"profile", @"visitorInfo": @{@"text":@"我的访客视图", @"imageName":@"profile", @"rotateImageName": @"profile_selected"}}];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *path = @"/Users/zyx/Desktop/test.json";
//    [data writeToFile:path atomically:YES];

    NSString *jsonPath = [kDocumentPath stringByAppendingPathComponent:@"appInfo.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    if (!jsonData) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
        jsonData = [NSData dataWithContentsOfFile:path];
    }
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [vcArray addObject:[self controllerWithDict:dict]];
    }
    
    self.viewControllers = vcArray;
}

#pragma mark --- 用字典创建控制器
- (UIViewController *)controllerWithDict:(NSDictionary *)dict {
    NSString *clsName = dict[@"clsName"];
    NSString *title = dict[@"title"];
    NSString *imageName = dict[@"imageName"];
    if (clsName == nil || title == nil || imageName == nil) {
        return [UIViewController new];
    }
    
    BaseViewController *BVC = [NSClassFromString(clsName) new];
    BVC.navItem.title = title;
    BVC.infoDict = dict[@"visitorInfo"];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:BVC];
    /// 设置标题、图片
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    /// 设置标题属性
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: kRGB16(0xdbb058), NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    /// 设置标题缩进
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 1)];
    
    return nav;
}

#pragma mark --- 加号按钮懒加载
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
