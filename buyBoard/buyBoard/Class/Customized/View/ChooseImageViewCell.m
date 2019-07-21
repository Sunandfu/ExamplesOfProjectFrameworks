//
//  ChooseImageViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "ChooseImageViewCell.h"

@implementation ChooseImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"ChooseImageViewCellIdentifier";
    return cellIdentifier;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
