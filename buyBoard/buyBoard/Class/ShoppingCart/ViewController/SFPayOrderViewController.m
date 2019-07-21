//
//  SFPayOrderViewController.m
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "SFPayOrderViewController.h"
#import "OrderTableView0Cell.h"
#import "OrderTableView1Cell.h"
#import "OrderTableView2Cell.h"
#import "OrderTableView3Cell.h"
#import "OrderTableView4Cell.h"
#import "OrderTableView5Cell.h"
#import "CustomModel.h"
#import "Masonry.h"

@interface SFPayOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *totalPriceLable;
@property (nonatomic, strong) UIButton *settleButton;
@property (nonatomic, strong) UILabel *totlaNumberLabel;

@end

@implementation SFPayOrderViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.type = NavigationTypeBlack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
    [self getSettingData];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.navigationView];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createBottomView];
}
- (void)createBottomView{
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.totalPriceLable];
    [self.bottomView addSubview:self.settleButton];
    [self.bottomView addSubview:self.totlaNumberLabel];
    [self renderWithTotalPrice];
}
- (void)getSettingData{
    for (int i=0; i<5; i++) {
        CustomModel *model = [self modelWithImageStr:@"demo" Title:@"马六甲生态板新款预售" Desc:@"暖白 1220*2240*17 进口马六甲" Price:@"¥87.00/张" Number:@"X1"];
        [self.dataArray addObject:model];
    }
}
- (CustomModel *)modelWithImageStr:(NSString *)imageStr Title:(NSString *)title Desc:(NSString *)desc Price:(NSString *)price Number:(NSString *)number{
    CustomModel *model = [[CustomModel alloc] init];
    model.imageStr = imageStr;
    model.title = title;
    model.desc = desc;
    model.price = price;
    model.number = number;
    return model;
}
- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 45)];
    return headerView;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [self tableViewHeaderView];
        for (int i=0; i<6; i++) {
            [_tableView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"OrderTableView%dCell",i] bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"OrderTableView%dCellID",i]];
        }
    }
    return _tableView;
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.dataArray.count+1;
            break;
        case 3:
            return 4;
            break;
            
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                OrderTableView1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableView1CellID" forIndexPath:indexPath];
                return cell;
            } else {
                OrderTableView0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableView0CellID" forIndexPath:indexPath];
                if (indexPath.row==1) {
                    cell.titleLabel.text = @"配送日期";
                } else {
                    cell.titleLabel.text = @"配送时间";
                }
                return cell;
            }
            break;
        case 1:
            {
                OrderTableView2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableView2CellID" forIndexPath:indexPath];
                return cell;
            }
            break;
        case 2:
            {
                if (indexPath.row==self.dataArray.count) {
                    OrderTableView4Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableView4CellID" forIndexPath:indexPath];
                    return cell;
                } else {
                    OrderTableView3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableView3CellID" forIndexPath:indexPath];
                    CustomModel *model = self.dataArray[indexPath.row];
                    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.imageStr] placeholderImage:[UIImage imageNamed:model.imageStr]];
                    cell.goodsTitle.text = model.title;
                    cell.goodsDesc.text = model.desc;
                    cell.goodsPrice.text = model.price;
                    cell.goodsNumber.text = model.number;
                    return cell;
                }
            }
            break;
        case 3:
            {
                OrderTableView5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableView5CellID" forIndexPath:indexPath];
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.titleLabel.text = @"会员优惠";
                        cell.viewCell1.hidden = NO;
                        cell.viewCell2.hidden = YES;
                        cell.viewCell3.hidden = YES;
                    }
                        break;
                    case 1:
                    {
                        cell.titleLabel.text = @"折扣";
                        cell.viewCell1.hidden = YES;
                        cell.viewCell2.hidden = NO;
                        cell.viewCell3.hidden = YES;
                    }
                        break;
                    case 2:
                    {
                        cell.titleLabel.text = @"运费";
                        cell.viewCell1.hidden = YES;
                        cell.viewCell2.hidden = NO;
                        cell.viewCell3.hidden = YES;
                    }
                        break;
                    case 3:
                    {
                        cell.titleLabel.text = @"是否开票";
                        cell.viewCell1.hidden = YES;
                        cell.viewCell2.hidden = YES;
                        cell.viewCell3.hidden = NO;
                    }
                        break;
                        
                    default:
                        break;
                }
                return cell;
            }
            break;
            
        default:
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID" forIndexPath:indexPath];
                return cell;
            }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row) {
                return HEIGHT(40);
            } else {
                return HEIGHT(70);
            }
            break;
        case 1:
            return HEIGHT(90);
            break;
        case 2:
            if (indexPath.row == self.dataArray.count) {
                return HEIGHT(50);
            } else {
                return HEIGHT(85);
            }
            break;
        case 3:
            return HEIGHT(40);
            break;
            
        default:
            return 0;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 15)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, CGFLOAT_MIN)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - bottomView
- (UIButton *)settleButton {
    if (_settleButton == nil){
        _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settleButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _settleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_settleButton setBackgroundColor:THEME_COLOR];
        [_settleButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _settleButton.layer.cornerRadius = 5;
        _settleButton.layer.masksToBounds = YES;
    }
    return _settleButton;
}
- (UILabel *)totalPriceLable {
    if (_totalPriceLable == nil){
        _totalPriceLable = [[UILabel alloc] init];
        _totalPriceLable.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        _totalPriceLable.textColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _totalPriceLable.numberOfLines = 1;
        _totalPriceLable.textAlignment = NSTextAlignmentRight;
        _totalPriceLable.text = @"合计：￥0";
    }
    return _totalPriceLable;
}
- (void)renderWithTotalPrice{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 2;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.totalPriceLable.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:128/255.0 green:130/255.0 blue:132/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]} range:[self.totalPriceLable.text rangeOfString:@"合计："]];
    self.totalPriceLable.attributedText = attributedString;
}
- (UILabel *)totlaNumberLabel{
    if (_totlaNumberLabel == nil){
        _totlaNumberLabel = [[UILabel alloc] init];
        _totlaNumberLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
        _totlaNumberLabel.textColor = [UIColor colorWithRed:128/255.0 green:130/255.0 blue:132/255.0 alpha:1];
        _totlaNumberLabel.numberOfLines = 1;
        _totlaNumberLabel.text = @"共两件";
    }
    return _totlaNumberLabel;
}
- (UIView *)bottomView{
    if (_bottomView == nil){
        _bottomView = [[UILabel alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.totlaNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(20);
//        make.top.bottom.equalTo(self.bottomView);
        make.centerY.equalTo(self.bottomView);
    }];
    
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).offset(-20);
        make.centerY.equalTo(self.bottomView);
        make.width.equalTo(@115);
        make.height.equalTo(@33);
    }];
    
    [self.totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bottomView);
        make.right.equalTo(self.settleButton.mas_left).offset(-60);
    }];
}
- (void)submitButtonAction{
    
}

@end
