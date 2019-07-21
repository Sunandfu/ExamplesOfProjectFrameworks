//
//  CollectionHeader.h
//  ft_procute
//
//  Created by gitBurning on 15/3/18.
//  Copyright (c) 2015年 ft_iem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *headerTitile;
@property (weak, nonatomic) IBOutlet UILabel *tag1label;
@property (weak, nonatomic) IBOutlet UILabel *tag2label;
@property (weak, nonatomic) IBOutlet UILabel *tag3label;

+ (NSString *)cellIdentifier;

@end
