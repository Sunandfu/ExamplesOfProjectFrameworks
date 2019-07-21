//
//  ClassificationViewController.m
//  buyBoard
//
//  Created by lurich on 2019/7/18.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "ClassificationViewController.h"
#import "SFScrollPageView.h"
#import "ClassDescViewController.h"

@interface ClassificationViewController ()<SFScrollPageViewDelegate,SFScrollPageViewChildVcDelegate>

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ClassificationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.type = NavigationTypeCustom;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSearchView];
    self.titles = @[@"木材",@"板材",@"钢材",@"铝材",@"题材",@"混合材",@"三合板",@"万能板"];
    [self createTitleViews];
    self.navigationView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.navigationView.layer.shadowOffset = CGSizeMake(0,0);
    self.navigationView.layer.shadowOpacity = 0.0;
    self.navigationView.layer.shadowRadius = 0;
}

- (void)createTitleViews{
    SFSegmentStyle *style = [[SFSegmentStyle alloc] init];
    // 缩放标题
    style.scaleTitle = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.titleMargin = 15;
    style.titleFont = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    style.titleBigScale = 1.2;
    style.selectedTitleColor = [[UIColor colorWithHexString:@"050b10"] colorWithAlphaComponent:1.0];
    style.normalTitleColor = [[UIColor colorWithHexString:@"a4a4a4"] colorWithAlphaComponent:1.0];
    SFScrollPageView *scrollPageView = [[SFScrollPageView alloc] initWithFrame:CGRectMake(0, self.navigationAndStatuHeight, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationAndStatuHeight) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    // 这里可以设置头部视图的属性(背景色, 圆角, 背景图片...)
    scrollPageView.segmentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollPageView];
    [self.view bringSubviewToFront:scrollPageView.segmentView];
    scrollPageView.segmentView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 阴影偏移，默认(0, -3)
    scrollPageView.segmentView.layer.shadowOffset = CGSizeMake(0,5);
    // 阴影透明度，默认0
    scrollPageView.segmentView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    scrollPageView.segmentView.layer.shadowRadius = 5;
}
//- (void)setShowDemarcationLine:(BOOL)showDemarcationLine{
//    _showDemarcationLine = showDemarcationLine;
//}
#pragma SFScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<SFScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<SFScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<SFScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    //    NSLog(@"%ld---------", index);
    
    if (!childVc) {
        NSString *title = self.titles[index];
        ClassDescViewController *newChildVc = [[ClassDescViewController alloc] init];
        newChildVc.title = title;
        return newChildVc;
    }
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    //    NSLog(@"%ld ---将要出现",index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    //    NSLog(@"%ld ---已经出现",index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    //    NSLog(@"%ld ---将要消失",index);
    
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    //    NSLog(@"%ld ---已经消失",index);
    
}

@end
