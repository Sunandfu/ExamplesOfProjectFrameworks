//
//  YXBottomPickdateweightView.h
//  fitness
//
//  Created by yunxiang on 2017/7/22.
//  Copyright © 2017年 YunXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,YXBottomPickViewType){
    YXArrayType = 1,       //传入数组显示数组列表
    YXHeightType = 2,      //身高
    YXBirthdayType= 3,     //生日
    YXDateType= 4,         //时间
} ;

@protocol  YXBottomPickerViewProtocol <NSObject>

- (void)didSelectNumer:(NSString*)result;
@optional
- (void)viewDidRemove;

@end

@interface YXBottomPickdateweightView : UIView

@property (nonatomic, copy) NSString *bodyHeight;
@property (nonatomic, copy) NSString * birthdayStr;
@property (nonatomic, copy) NSString *yearAndMonthdateStr;

@property (nonatomic, copy) NSString * bodyList;//  默认选中项
@property (nonatomic,strong) NSArray* listArr;// 数据源
@property (nonatomic,copy) NSString * listTitle;  //选择项标题
@property (nonatomic,copy) NSString * listDetail; //选择项单位

@property (nonatomic,assign)id<YXBottomPickerViewProtocol>delegate;
//先配置数据  最后配置类型
@property (nonatomic,assign) YXBottomPickViewType pickViewType;

- (void)appearAnimation;

@end
