//
//  BaseViewController.m
//  museum
//
//  Created by 小富 on 2017/11/8.
//  Copyright © 2017年 xiaofu. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "UIButton+JKImagePosition.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //默认白底黑字
    self.type = NavigationTypeBlack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarBgAlpha = @"0.0";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.tabBarController) {
        self.tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    } else {
        self.tabBarHeight = 0;
    }
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (StatusRect.size.height == 40) {
        StatusRect = CGRectMake(0, 0, StatusRect.size.width, 20);
    }
    self.statusBarHeight = StatusRect.size.height;
    self.navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    self.navigationAndStatuHeight = self.statusBarHeight + self.navigationBarHeight;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
    
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, self.navigationAndStatuHeight)];
    self.navigationView.backgroundColor = THEME_COLOR;
    [self.view addSubview:self.navigationView];
    [self addShadowToView:self.navigationView withColor:[UIColor lightGrayColor]];
}
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)setType:(NavigationType)type{
    _type = type;
    //如果自定义返回按钮。请打开
    if (self.navigationController.viewControllers.count>1) {
        [self addLeftBackButton];
    }
    self.navigationController.navigationBar.hidden = NO;
    [self.view bringSubviewToFront:self.navigationView];
    switch (type) {
        case NavigationTypeBlack:
        {
            // 设置导航栏标题和返回按钮颜色
            self.navigationView.backgroundColor = [UIColor whiteColor];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            //返回按钮颜色
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
        }
            break;
        case NavigationTypeWhite:
        {
            // 设置导航栏标题和返回按钮颜色
            self.navigationView.backgroundColor = THEME_COLOR;
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
            //返回按钮颜色
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
            break;
        case NavigationTypeClean:
        {
            self.navigationView.backgroundColor = [UIColor clearColor];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            self.navigationController.navigationBar.hidden = YES;
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            //返回按钮颜色
            self.navigationController.navigationBar.tintColor = [UIColor clearColor];
        }
            break;
        case NavigationTypeVariableWhite:
        {
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
            //返回按钮颜色
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
            break;
        case NavigationTypeVariableBlack:
        {
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            //返回按钮颜色
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
        }
            break;
        case NavigationTypeCustom:
        {
            self.navigationView.backgroundColor = [UIColor whiteColor];
            self.navigationController.navigationBar.hidden = YES;
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            //返回按钮颜色
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
            break;
            
        default:
            break;
    }
}
- (UIWindow *)window
{
    return [UIApplication sharedApplication].delegate.window;
}
- (void)addSearchView{
    CGFloat notiW = 55;
    //searchBar设置
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(20, self.statusBarHeight + 5, self.view.frame.size.width-40-notiW, 34)];
    searchBar.placeholder = @"查找产品";
    //    searchBar.delegate=self;
    //1.
    searchBar.backgroundColor = [UIColor whiteColor];
    //2.关键
    [[[searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    
    //显示取消按钮
    searchBar.showsCancelButton=NO;
    UIButton *cancelBtn=[searchBar valueForKey:@"_cancelButton"];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //设置光标的颜色
    searchBar.tintColor=[UIColor blackColor];
    
    UITextField *searchFiled=[searchBar valueForKey:@"_searchField"];
    //设置处于编辑状态
    //    [searchFiled becomeFirstResponder];
    //输入文本的颜色
    searchFiled.textColor=[UIColor grayColor];
    //输入文本字体的大小
    searchFiled.font=[UIFont systemFontOfSize:14];
    //输入框的圆角设置
    searchFiled.layer.cornerRadius = searchBar.bounds.size.height/2.0;;
    searchFiled.layer.masksToBounds = YES;
    //    [searchBar.layer setBorderWidth:1];
    //    [searchBar.layer setBorderColor:[UIColor greenColor].CGColor];
    //输入框里面的背景颜色
    searchFiled.backgroundColor=[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.7];
    //提示文本的颜色
    [searchFiled setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //输入框里的图标
    [searchBar setImage:[UIImage imageNamed:@"sousuohui"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.navigationView addSubview:searchBar];
    UIButton *button = [SFTool createButtonWithTitle:nil frame:searchBar.frame target:self selector:@selector(searchBarClick)];
    [self.navigationView addSubview:button];
    self.searchBar = searchBar;
    UIButton *notiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    notiButton.frame = CGRectMake(searchBar.kaf_right +5, self.statusBarHeight, notiW-5, self.navigationBarHeight);
    [notiButton setImage:[UIImage imageNamed:@"notiIconNor"] forState:UIControlStateNormal];
    [notiButton setImage:[UIImage imageNamed:@"notiIconSel"] forState:UIControlStateSelected];
    [notiButton setTitle:@"消息" forState:UIControlStateNormal];
    [notiButton setTitle:@"消息" forState:UIControlStateSelected];
    [notiButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [notiButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    notiButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    notiButton.tag = 333;
    [notiButton jk_setImagePosition:LXMImagePositionLeft spacing:5];
    [self.navigationView addSubview:notiButton];
}

- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}
- (void)searchBarClick{
    NSLog(@"搜索框点击");
}
- (void)addLeftBackButton
{
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改按钮向右偏移10 point
    [settingButton setFrame:CGRectMake(-15.0, 0.0, 44.0, 44.0)];
    [settingButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.type == NavigationTypeBlack) {
        [settingButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    } else {
        [settingButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    
    //修改方法
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view addSubview:settingButton];
    view.userInteractionEnabled = YES;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)backAction
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
