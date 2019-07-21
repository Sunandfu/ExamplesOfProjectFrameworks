//
//  OrderTableView2Cell.h
//  buyBoard
//
//  Created by lurich on 2019/7/20.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableView2Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelAdress;

@end

NS_ASSUME_NONNULL_END
