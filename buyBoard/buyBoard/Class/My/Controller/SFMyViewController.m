//
//  SFMyViewController.m
//  AppProjectDemo
//
//  Created by 史岁富 on 2018/5/28.
//  Copyright © 2018年 xiaofu. All rights reserved.
//

#import "SFMyViewController.h"
#import "SFUserHeaderViewCell.h"
#import "SFMyOrderViewCell.h"
#import "SFMyToolViewCell.h"
#import "UIButton+JKImagePosition.h"

@interface SFMyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SFMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *orangeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationAndStatuHeight, DEVICE_WIDTH, HEIGHT(60))];
    orangeView.backgroundColor = THEME_COLOR;
    [self.view addSubview:orangeView];
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.type = NavigationTypeBlack;
}
- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, HEIGHT(20))];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (UIView *)tableViewFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *button = [SFTool createButtonWithTitle:@"退出登录" frame:CGRectMake(20, 10, DEVICE_WIDTH-40, footerView.kaf_height-10) target:self selector:@selector(exitLogin)];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [footerView addSubview:button];
    return footerView;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self tableViewHeaderView];
        _tableView.tableFooterView = [self tableViewFooterView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFUserHeaderViewCell class]) bundle:nil] forCellReuseIdentifier:[SFUserHeaderViewCell cellIdentifier]];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFMyOrderViewCell class]) bundle:nil] forCellReuseIdentifier:[SFMyOrderViewCell cellIdentifier]];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFMyToolViewCell class]) bundle:nil] forCellReuseIdentifier:[SFMyToolViewCell cellIdentifier]];
    }
    return _tableView;
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            SFUserHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFUserHeaderViewCell cellIdentifier] forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            SFMyOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFMyOrderViewCell cellIdentifier] forIndexPath:indexPath];
            return cell;
        }
            break;
        case 2:
        {
            SFMyToolViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFMyToolViewCell cellIdentifier] forIndexPath:indexPath];
            NSArray *nameArray = @[@"地址管理",@"退货单",@"我的定制",@"账户信息",@"我的额度",@"开票资料",@"快速联系"];
            CGFloat btnW = (DEVICE_WIDTH-60)/4.0;
            CGFloat btnH = HEIGHT(60);
            for (int i=0; i<7; i++) {
                UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                toolBtn.frame = CGRectMake(10+btnW*(i%4), HEIGHT(15)+(btnH+HEIGHT(15))*(i/4), btnW, btnH);
                [toolBtn setTitle:nameArray[i] forState:UIControlStateNormal];
                [toolBtn setTitleColor:[UIColor colorWithHexString:@"898989"] forState:UIControlStateNormal];
                [toolBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"myIcon%d",i+1]] forState:UIControlStateNormal];
                toolBtn.tag = i;
                toolBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
                [toolBtn jk_setImagePosition:LXMImagePositionTop spacing:5];
                [cell.backView addSubview:toolBtn];
            }
            return cell;
        }
            break;
            
        default:
        {
            static NSString *cellID = @"UITableViewCellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            return cell;
        }
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return HEIGHT(120);
            break;
        case 1:
            return HEIGHT(115);
            break;
        case 2:
            return HEIGHT(165);
            break;
            
        default:
            return CGFLOAT_MIN;
            break;
    }
}
- (void)exitLogin{
    NSLog(@"退出登录");
}
@end
