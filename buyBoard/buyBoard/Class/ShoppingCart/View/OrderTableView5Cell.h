//
//  OrderTableView5Cell.h
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableView5Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *viewCell1;
@property (weak, nonatomic) IBOutlet UILabel *view1DescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *view1MineImg;

@property (weak, nonatomic) IBOutlet UIView *viewCell2;
@property (weak, nonatomic) IBOutlet UILabel *view2PriceLabel;

@property (weak, nonatomic) IBOutlet UIView *viewCell3;
@property (weak, nonatomic) IBOutlet UIButton *view3YesButton;
@property (weak, nonatomic) IBOutlet UIButton *view3NoButton;

@end

NS_ASSUME_NONNULL_END
