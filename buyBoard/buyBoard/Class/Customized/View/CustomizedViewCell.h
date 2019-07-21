//
//  CustomizedViewCell.h
//  buyBoard
//
//  Created by lurich on 2019/7/18.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomModel;

NS_ASSUME_NONNULL_BEGIN

@interface CustomizedViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *importantLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentField;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

+ (NSString *)cellIdentifier;

- (void)drawCellWithModel:(CustomModel *)model;

@end

NS_ASSUME_NONNULL_END
