//
//  CustomModel.h
//  buyBoard
//
//  Created by lurich on 2019/7/18.
//  Copyright © 2019 lurich. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) BOOL isImportant;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BOOL isChoose;

@property (nonatomic, copy) NSString *tagString;
@property (nonatomic, copy) NSString *result;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *number;


@end

NS_ASSUME_NONNULL_END
