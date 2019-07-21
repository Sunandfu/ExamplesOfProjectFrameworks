//
//  SFUserHeaderViewCell.h
//  buyBoard
//
//  Created by lurich on 2019/7/19.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFUserHeaderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UIImageView *gradeImageView;
@property (weak, nonatomic) IBOutlet UILabel *keyongedu;
@property (weak, nonatomic) IBOutlet UILabel *huankuanyue;

+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
