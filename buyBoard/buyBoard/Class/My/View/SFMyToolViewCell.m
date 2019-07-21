//
//  SFMyToolViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/19.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "SFMyToolViewCell.h"

@implementation SFMyToolViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 3;
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"SFMyToolViewCellIdentifier";
    return cellIdentifier;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
