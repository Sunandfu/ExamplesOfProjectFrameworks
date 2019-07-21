//
//  CollectionHeader.m
//  ft_procute
//
//  Created by gitBurning on 15/3/18.
//  Copyright (c) 2015年 ft_iem. All rights reserved.
//

#import "CollectionHeader.h"

@implementation CollectionHeader

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.tag1label.layer.masksToBounds = self.tag2label.layer.masksToBounds = self.tag3label.layer.masksToBounds = YES;
    self.tag1label.layer.cornerRadius = self.tag2label.layer.cornerRadius = self.tag3label.layer.cornerRadius = 11.0;
}
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"CollectionHeaderIdentifier";
    return cellIdentifier;
}

@end
