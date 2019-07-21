//
//  BaseTabBarController.m
//  museum
//
//  Created by 小富 on 2017/11/8.
//  Copyright © 2017年 xiaofu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "SFHomeViewController.h"
#import "SFMyViewController.h"
#import "SFLoginViewController.h"
#import "ClassificationViewController.h"
#import "CustomizedViewController.h"
#import "JVShopcartViewController.h"

@interface BaseTabBarController ()<CYTabBarDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 配置
    [CYTabBarConfig shared].selectedTextColor = THEME_COLOR;
    [CYTabBarConfig shared].textColor = [UIColor colorWithHexColor:@"050b10" andOpacity:1.0];
    [CYTabBarConfig shared].backgroundColor = [UIColor whiteColor];
    [CYTabBarConfig shared].selectIndex = 0;
//    [CYTabBarConfig shared].centerBtnIndex = 2;
    [CYTabBarConfig shared].HidesBottomBarWhenPushedOption = HidesBottomBarWhenPushedAlone;
    // Do any additional setup after loading the view.
    [self setChildViewController];
}

- (void)setChildViewController
{
    SFHomeViewController * homeVC = [SFHomeViewController new];
    BaseNavigationController * homeNav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
    [self addChildController:homeNav title:@"首页" imageName:@"icon1" selectedImageName:@"icon2"];
    
    ClassificationViewController * classVC = [ClassificationViewController new];
    BaseNavigationController * classNav = [[BaseNavigationController alloc]initWithRootViewController:classVC];
    [self addChildController:classNav title:@"分类" imageName:@"icon3" selectedImageName:@"icon4"];
    
    CustomizedViewController *  customVC = [CustomizedViewController new];
    BaseNavigationController * customNav = [[BaseNavigationController alloc]initWithRootViewController:customVC];
    [self addChildController:customNav title:@"定制" imageName:@"icon5" selectedImageName:@"icon6"];
    
    JVShopcartViewController * shopVC = [JVShopcartViewController new];
    BaseNavigationController * shopNav = [[BaseNavigationController alloc]initWithRootViewController:shopVC];
    [self addChildController:shopNav title:@"购物车" imageName:@"icon7" selectedImageName:@"icon8"];

    SFMyViewController * myVC = [SFMyViewController new];
    BaseNavigationController * myNav = [[BaseNavigationController alloc]initWithRootViewController:myVC];
    [self addChildController:myNav title:@"我的" imageName:@"icon9" selectedImageName:@"icon10"];

//    [self addCenterController:nil bulge:NO title:nil imageName:@"pub" selectedImageName:@"pub"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabbar.delegate = self;
}
#pragma mark - CYTabBarDelegate
//中间按钮点击
- (void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton{
    NSLog(@"中间按钮点击");
}
//是否允许切换
- (BOOL)tabBar:(CYTabBar *)tabBar willSelectIndex:(NSInteger)index{
    NSLog(@"将要切换到---> %ld",index);
    return YES;
}
//通知切换的下标
- (void)tabBar:(CYTabBar *)tabBar didSelectIndex:(NSInteger)index{
    NSLog(@"切换到---> %ld",index);
}
@end
