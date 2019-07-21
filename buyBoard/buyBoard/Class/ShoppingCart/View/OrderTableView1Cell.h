//
//  OrderTableView1Cell.h
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableView1Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *distributionAmount;

@end

NS_ASSUME_NONNULL_END
