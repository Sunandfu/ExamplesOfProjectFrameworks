//
//  MultilevelCollectionViewCell.m
//  MultilevelMenu
//
//  Created by gitBurning on 15/3/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "MultilevelCollectionViewCell.h"

@implementation MultilevelCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"MultilevelCollectionViewCellIdentifier";
    return cellIdentifier;
}

@end
