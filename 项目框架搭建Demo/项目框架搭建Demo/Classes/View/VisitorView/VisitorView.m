//
//  VisitorView.m
//  项目框架搭建Demo
//
//  Created by zyx on 17/3/22.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "VisitorView.h"

@interface VisitorView ()
/// 提示标签
@property (nonatomic, strong) UILabel *label;
/// 提示图片
@property (nonatomic, strong) UIImageView *imageView;
/// 旋转图片
@property (nonatomic, strong) UIImageView *rotateImageView;

@end

@implementation VisitorView
#pragma mark --- 重写初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark --- 设置视图
- (void)setupUI {
    UIImageView *rotateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    rotateImageView.center = CGPointMake(self.center.x, 170);
    [self addSubview:rotateImageView];
    self.rotateImageView = rotateImageView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center = self.center;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    label.center = CGPointMake(self.center.x, self.center.y+100);
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = kRGB16(0xdbb058);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"  登陆  " forState:UIControlStateNormal];
    [button setTitleColor:kRGB16(0xdbb058) forState:UIControlStateNormal];
    [button setBackgroundColor:kRGB16(0xeeeeee)];
    button.titleLabel.font = [UIFont systemFontOfSize:50];
    [button sizeToFit];
    button.center = CGPointMake(self.center.x, self.center.y+200);
    [self addSubview:button];
    self.loginButton = button;
}

#pragma mark --- 旋转动画
- (void)startAnimation {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = @(2*M_PI);
    anim.repeatCount = HUGE_VALF;
    anim.duration = 5;
    // 防止动画结束停止
    anim.removedOnCompletion = NO;
    
    [self.rotateImageView.layer addAnimation:anim forKey:nil];
}

#pragma mark --- 设置数据
- (void)setInfoDict:(NSDictionary *)infoDict {
    _infoDict = infoDict;
    
    NSString *text = _infoDict[@"text"];
    NSString *imageName = _infoDict[@"imageName"];
    NSString *rotateImageName = _infoDict[@"rotateImageName"];
    if (text) {
        self.label.text = text;
    }
    if (imageName) {
        self.imageView.image = [UIImage imageNamed:imageName];
    }
    if (rotateImageName) {
        self.rotateImageView.image = [UIImage imageNamed:rotateImageName];
        [self startAnimation];
    }
}

@end
