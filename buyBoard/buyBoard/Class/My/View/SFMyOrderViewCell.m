//
//  SFMyOrderViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/19.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "SFMyOrderViewCell.h"
#import "UIButton+JKImagePosition.h"

@implementation SFMyOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 3;
    [self.waitPay jk_setImagePosition:LXMImagePositionTop spacing:5];
    [self.waitSend jk_setImagePosition:LXMImagePositionTop spacing:5];
    [self.alreadySend jk_setImagePosition:LXMImagePositionTop spacing:5];
    [self.alreadyTake jk_setImagePosition:LXMImagePositionTop spacing:5];
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"SFMyOrderViewCellIdentifier";
    return cellIdentifier;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
