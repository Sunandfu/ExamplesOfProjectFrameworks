//
//  NotificationViewCell.h
//  buyBoard
//
//  Created by lurich on 2019/7/17.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *notiLabel;

+(NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
