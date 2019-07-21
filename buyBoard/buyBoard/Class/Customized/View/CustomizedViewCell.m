//
//  CustomizedViewCell.m
//  buyBoard
//
//  Created by lurich on 2019/7/18.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "CustomizedViewCell.h"
#import "CustomModel.h"

@implementation CustomizedViewCell

+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"CustomizedViewCellIdentifier";
    return cellIdentifier;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)drawCellWithModel:(CustomModel *)model{
    self.nameLabel.text = model.name;
    self.descLabel.text = model.desc;
    self.importantLabel.hidden = !model.isImportant;
    self.contentField.placeholder = model.placeholder;
    self.chooseBtn.hidden = !model.isChoose;
    if (model.result && model.result.length>0) {
        self.contentField.text = model.result;
    } else {
        self.contentField.text = @"";
    }
    if (model.isChoose) {
        self.contentField.enabled = NO;
    } else {
        self.contentField.enabled = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
