//
//  UIBarButtonItem+Extension.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/21.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action isBack:(BOOL)isBack {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:kRGB16(0xdbb058) forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (isBack) {
        [button setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"backIcon_selected"] forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
