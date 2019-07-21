//
//  SFMyOrderViewCell.h
//  buyBoard
//
//  Created by lurich on 2019/7/19.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFMyOrderViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *lookAllOrder;
@property (weak, nonatomic) IBOutlet UIButton *waitPay;
@property (weak, nonatomic) IBOutlet UIButton *waitSend;
@property (weak, nonatomic) IBOutlet UIButton *alreadySend;
@property (weak, nonatomic) IBOutlet UIButton *alreadyTake;

+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
