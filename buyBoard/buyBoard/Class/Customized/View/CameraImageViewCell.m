//
//  CameraImageViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "CameraImageViewCell.h"

@implementation CameraImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"CameraImageViewCellIdentifier";
    return cellIdentifier;
}

@end
