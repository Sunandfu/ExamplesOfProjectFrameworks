//
//  HomeCollectionViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/17.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//方块视图的缓存池标示
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"HomeCollectionViewCellIdentifier";
    return cellIdentifier;
}
//获取方块视图对象
+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[HomeCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    return cell;
    
}

@end
