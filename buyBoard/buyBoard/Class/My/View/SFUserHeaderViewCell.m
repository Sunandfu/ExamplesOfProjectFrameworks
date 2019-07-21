//
//  SFUserHeaderViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/19.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "SFUserHeaderViewCell.h"

@implementation SFUserHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 3;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = self.userImageView.kaf_height/2.0;
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"SFUserHeaderViewCellIdentifier";
    return cellIdentifier;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
