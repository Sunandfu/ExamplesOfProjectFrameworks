//
//  JVShopcartCell.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JVShopcartCountView.h"

@interface JVShopcartCell ()

@property (nonatomic, strong) UIButton *productSelectButton;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLable;
@property (nonatomic, strong) UILabel *productSizeLable;
@property (nonatomic, strong) UILabel *productPriceLable;
@property (nonatomic, strong) JVShopcartCountView *shopcartCountView;
@property (nonatomic, strong) UILabel *productStockLable;
@property (nonatomic, strong) UIView *shopcartBgView;
@property (nonatomic, strong) UIView *topLineView;

@end

@implementation JVShopcartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productSelectButton];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productSizeLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.shopcartCountView];
//    [self.shopcartBgView addSubview:self.productStockLable];
    [self.shopcartBgView addSubview:self.topLineView];
}

- (void)configureShopcartCellWithProductURL:(NSString *)productURL productName:(NSString *)productName productSize:(NSString *)productSize productPrice:(NSInteger)productPrice productCount:(NSInteger)productCount productStock:(NSInteger)productStock productSelected:(BOOL)productSelected {
//    NSURL *encodingURL = [NSURL URLWithString:[productURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.productImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"demo"]];
    self.productNameLable.text = productName;
    self.productSizeLable.text = productSize;
    self.productPriceLable.text = [NSString stringWithFormat:@"￥%.2f/张", (double)productPrice];
    self.productSelectButton.selected = productSelected;
    [self.shopcartCountView configureShopcartCountViewWithProductCount:productCount productStock:productStock];
    self.productStockLable.text = [NSString stringWithFormat:@"库存:%ld", productStock];
}

- (void)productSelectButtonAction {
    self.productSelectButton.selected = !self.productSelectButton.isSelected;
    if (self.shopcartCellBlock) {
        self.shopcartCellBlock(self.productSelectButton.selected);
    }
}

- (UIButton *)productSelectButton
{
    if(_productSelectButton == nil)
    {
        _productSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_productSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_productSelectButton addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectButton;
}

- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}

- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.font = [UIFont systemFontOfSize:HFont(14) weight:UIFontWeightMedium];
        _productNameLable.textColor = [UIColor colorWithRed:5/255.0 green:11/255.0 blue:16/255.0 alpha:1];
    }
    return _productNameLable;
}

- (UILabel *)productSizeLable {
    if (_productSizeLable == nil){
        _productSizeLable = [[UILabel alloc] init];
        _productSizeLable.font = [UIFont systemFontOfSize:HFont(12) weight:UIFontWeightLight];
        _productSizeLable.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1];
    }
    return _productSizeLable;
}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:HFont(14)];
        _productPriceLable.textColor = [UIColor colorWithRed:1  green:0  blue:0 alpha:1];
    }
    return _productPriceLable;
}

- (JVShopcartCountView *)shopcartCountView {
    if (_shopcartCountView == nil){
        _shopcartCountView = [[JVShopcartCountView alloc] init];
        _shopcartCountView.layer.masksToBounds = YES;
        _shopcartCountView.layer.borderWidth = 1.0;
        _shopcartCountView.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _shopcartCountView.layer.cornerRadius = 7;
        __weak __typeof(self) weakSelf = self;
        _shopcartCountView.shopcartCountViewEditBlock = ^(NSInteger count){
            if (weakSelf.shopcartCellEditBlock) {
                weakSelf.shopcartCellEditBlock(count);
            }
        };
    }
    return _shopcartCountView;
}

- (UILabel *)productStockLable {
    if (_productStockLable == nil){
        _productStockLable = [[UILabel alloc] init];
        _productStockLable.font = [UIFont systemFontOfSize:13];
        _productStockLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productStockLable;
}

- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
        _shopcartBgView.layer.masksToBounds = YES;
        _shopcartBgView.layer.cornerRadius = 5;
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.productSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(10);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(50);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(100, 68));
    }];
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
//        make.top.equalTo(self.shopcartBgView).offset(10);
        make.top.equalTo(self.productImageView.mas_top).offset(0);
        make.right.equalTo(self.shopcartBgView).offset(-10);
    }];
    
    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
//        make.top.equalTo(self.productNameLable.mas_bottom);
//        make.right.equalTo(self.shopcartBgView).offset(-10);
        make.centerY.equalTo(self.shopcartBgView);
        make.height.equalTo(@20);
    }];
    
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
//        make.top.equalTo(self.productSizeLable.mas_bottom).offset(0);
        make.bottom.equalTo(self.productImageView.mas_bottom).offset(0);
        make.right.equalTo(self.shopcartCountView.mas_left).offset(-10);
    }];
    
    [self.shopcartCountView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.productSizeLable.mas_bottom).offset(0);
        make.bottom.equalTo(self.productImageView.mas_bottom).offset(0);
        make.right.equalTo(self.shopcartBgView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(82, 22));
    }];
    
//    [self.productStockLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.shopcartCountView.mas_right).offset(20);
//        make.centerY.equalTo(self.shopcartCountView);
//    }];
    
    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(50);
        make.bottom.right.equalTo(self.shopcartBgView);
        make.height.equalTo(@0.4);
    }];
}

@end
