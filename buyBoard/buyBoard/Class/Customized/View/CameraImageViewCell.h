//
//  CameraImageViewCell.h
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraImageViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cameraImg;
@property (weak, nonatomic) IBOutlet UIButton *delegateBtn;

+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
