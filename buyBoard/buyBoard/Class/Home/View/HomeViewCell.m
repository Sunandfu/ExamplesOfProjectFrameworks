//
//  HomeViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/17.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "HomeViewCell.h"

@implementation HomeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"HomeViewCellIdentifier";
    return cellIdentifier;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
