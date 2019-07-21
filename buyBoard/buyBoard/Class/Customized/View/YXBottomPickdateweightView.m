//
//  YXBottomPickdateweightView.m
//  fitness
//
//  Created by yunxiang on 2017/7/22.
//  Copyright © 2017年 YunXiang. All rights reserved.
//

#import "YXBottomPickdateweightView.h"

@interface YXBottomPickdateweightView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSInteger currentYear;
    NSInteger currentMonth;
    
    NSString *selectedYear;
    NSString *selectecMonth;
}
@property (nonatomic,strong)UIPickerView *picker;

@property (nonatomic,strong) UIView *showView;

@property (nonatomic,strong) NSString *resultString;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *unitLabel;

@property (nonatomic,strong) UIDatePicker * datePicker;
@property (nonatomic,assign) CGFloat pickerHeight;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableArray *heightArr;

@end

@implementation YXBottomPickdateweightView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RCOLOR(0, 0, 0, 0);
        self.pickerHeight = HEIGHT(320);
        [self customUI];
    }
    return self;
}
- (UIView *)showView
{
    if (!_showView) {
        _showView = [SFTool createViewWithBackgroundColor:[UIColor whiteColor] frame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, self.pickerHeight)];
    }
    return _showView;
}
- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, HEIGHT(50), DEVICE_WIDTH, HEIGHT(200))];
        
        _datePicker.datePickerMode = UIDatePickerModeDate;
        if (!self.birthdayStr) {
            self.birthdayStr = @"1900-01-01";
        }
        NSDate *minDate = [self.dateFormatter dateFromString:@"1900-01-01"];
        NSDate *maxDate = [self.dateFormatter dateFromString:@"2100-12-31"];
        
        [_datePicker setMaximumDate:maxDate];
        [_datePicker setMinimumDate:minDate];
        _datePicker.date = [self.dateFormatter dateFromString:self.birthdayStr];
        [_datePicker setValue:[UIColor colorWithHexString:@"0x292936"] forKey:@"textColor"];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

-(UIPickerView *)picker
{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT(50), DEVICE_WIDTH, HEIGHT(200))];
        _picker.delegate = self;
    }
    return _picker;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [SFTool createLabelWithTitle:@"" frame:CGRectMake(0, 0, DEVICE_WIDTH, HEIGHT(50)) textColor:[UIColor colorWithHexString:@"0x050b10"] fontSize:HEIGHT(15)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)unitLabel
{
    if (!_unitLabel) {
        _unitLabel = [SFTool createLabelWithTitle:@"" frame:CGRectMake(DEVICE_WIDTH/2+WIDTH(24), 0, WIDTH(88), HEIGHT(200)) textColor:[UIColor colorWithHexString:@"0x292936"] fontSize:HFont(15)];
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.font = [UIFont systemFontOfSize:HFont(15)];
    }
    return _unitLabel;
}
- (void)setPickViewType:(YXBottomPickViewType)pickViewType
{
    _pickViewType = pickViewType;
    if (pickViewType == YXDateType) {
        [self.showView addSubview:self.picker];
        self.titleLabel.text = @"选择时间";
        [self initDateYearAndMonth];
    } else if (pickViewType == YXHeightType) {
        [self.showView addSubview:self.picker];
        [self.picker addSubview:self.unitLabel];
        self.titleLabel.text = @"设置身高";
        self.unitLabel.text = @"cm";
        NSInteger inter = [self.bodyHeight integerValue];
        if (inter<50) {
            inter=165;
        }
        [self.picker selectRow:inter-50 inComponent:0 animated:NO];
        
    } else if (pickViewType == YXBirthdayType) {
        self.titleLabel.text = @"设置生日";
        self.datePicker.date = [self.dateFormatter dateFromString:self.birthdayStr];
        [self.showView addSubview:self.datePicker];
        
        [self removeLineView];
        [self addPickLineView];
        
    } else if (pickViewType == YXArrayType) {
        self.picker.delegate = self;
        [self.showView addSubview:self.picker];
        [self.picker addSubview:self.unitLabel];
        self.titleLabel.text = self.listTitle;
        self.unitLabel.text = self.listDetail;
        NSInteger index;
        if ([self.listArr containsObject:self.bodyList]) {
            index = [self.listArr indexOfObject:self.bodyList];
        } else {
            index = 0;
        }
        [self.picker selectRow:index inComponent:0 animated:NO];
    }
}
- (void)removeLineView //UIDataPickView 分割线颜色
{
    for (UIView * subView1 in _datePicker.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView*subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    UIView *views = [_datePicker viewWithTag:subView2.kaf_top];
                    [views removeFromSuperview];
                }
            }
        }
    }
}
- (void)addPickLineView
{
    for (UIView * subView1 in _datePicker.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView*subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    UIView *views = [SFTool createViewWithBackgroundColor:[UIColor colorWithHexString:@"f8f8f8"] frame:subView2.frame];
                    views.tag = subView2.kaf_top;
                    
                    [_datePicker addSubview:views];
                    subView2.hidden = YES;
                }
            }
        }
    }
}
- (void)customUI{
    [self addSubview:self.showView];
    [self.showView addSubview:self.titleLabel];

    UIView *btnView = [SFTool createViewWithBackgroundColor:[UIColor colorWithHexString:@"0xf8f8f9"] frame:CGRectMake(0, HEIGHT(250), DEVICE_WIDTH, HEIGHT(70))];
    [self.showView addSubview:btnView];
    UIButton *doneBtn = [SFTool createButtonWithTitle:@"确定" frame:CGRectMake(0, 15, DEVICE_WIDTH, HEIGHT(55)) target:self selector:@selector(DoneClick)];
    [doneBtn setTitleColor:[UIColor colorWithHexString:@"0x494c5b"] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:doneBtn];
}
- (void)initDateYearAndMonth
{
    //获取当前时间 （时间格式支持自定义）
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    if (dateArray.count == 2) {//年 月
        currentYear = [[dateArray firstObject]integerValue];
        currentMonth =  [dateArray[1] integerValue];
    }
    
    
    selectedYear = [NSString stringWithFormat:@"%ld",(long)currentYear];
    selectecMonth = [NSString stringWithFormat:@"%02ld",(long)currentMonth];
    //初始化年数据源数组
    yearArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 2014; i <= currentYear ; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%ld年",(long)i];
        [yearArray addObject:yearStr];
    }
    //初始化月数据源数组
    monthArray = [[NSMutableArray alloc]init];
    
    if (self.yearAndMonthdateStr) {
        if ([[self.yearAndMonthdateStr substringToIndex:4] integerValue] == currentYear) {
            for (NSInteger i = 1 ; i <= currentMonth; i++) {
                NSString *monthStr = [NSString stringWithFormat:@"%02ld月",(long)i];
                [monthArray addObject:monthStr];
            }
        }else{
            for (NSInteger i = 1 ; i <= 12; i++) {
                NSString *monthStr = [NSString stringWithFormat:@"%02ld月",(long)i];
                [monthArray addObject:monthStr];
            }
        }
    }else{
        for (NSInteger i = 1 ; i <= currentMonth; i++) {
            NSString *monthStr = [NSString stringWithFormat:@"%02ld月",(long)i];
            [monthArray addObject:monthStr];
        }
    }
    
    //设置pickerView默认选中当前时间
    [_picker selectRow:[selectedYear integerValue] - 2014 inComponent:0 animated:YES];
    [_picker selectRow:[selectecMonth integerValue] - 1 inComponent:1 animated:YES];
}
- (NSMutableArray *)heightArr
{
    if (!_heightArr) {
        _heightArr = [NSMutableArray array];
        for (NSInteger index = 50; index < 201; index ++) {
            [_heightArr addObject:@(index)];
        }
    }
    return _heightArr;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

#pragma mark - pickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_pickViewType == YXDateType) {
        return 2;
    }
    return 1;//列数
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(_pickViewType == YXDateType){
        if (component == 0) {
            return yearArray.count;
        } else {
            return monthArray.count;
        }
    }else if(_pickViewType == YXHeightType){
        return self.heightArr.count;
    }else if(_pickViewType == YXArrayType){
        return self.listArr.count;
    }else{
        return 24;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;//component中一行的尺寸
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return DEVICE_WIDTH/2;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height <= 1)
        {
            singleLine.backgroundColor = [UIColor colorWithHexString:@"f2f3f4"];
        }
    }
    
    UILabel * pickerLab = (UILabel *)view;
    if (!pickerLab) {
        pickerLab = [UILabel new];
        pickerLab.textAlignment = NSTextAlignmentCenter;
        pickerLab.textColor = [UIColor colorWithHexString:@"0x292936"];
        pickerLab.font = [UIFont boldSystemFontOfSize:HFont(18)];
    }
    pickerLab.text = [self pickerView:pickerView titleForRow:row forComponent:component label:pickerLab];
    return pickerLab;
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
                   label:(UILabel*)label
{
    if (self.pickViewType == YXDateType) {
        if (component == 0) {
            return yearArray[row];
        } else {
            return monthArray[row];
        }
    }else if (self.pickViewType == YXHeightType) {
        label.font = [UIFont boldSystemFontOfSize:HFont(21)];
        NSString * str = [NSString stringWithFormat:@"%ld",row+50];
        return str;
    }else if (self.pickViewType == YXArrayType) {
        label.font = [UIFont boldSystemFontOfSize:HFont(21)];
        NSString * str = [NSString stringWithFormat:@"%@",self.listArr[row]];
        return str;
    }else{
        label.font = [UIFont boldSystemFontOfSize:HFont(21)];
        NSString * str = [NSString stringWithFormat:@"%ld",row];
        return str;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(self.pickViewType == YXDateType){
        if (component == 0) {
            selectedYear = yearArray[row];
            monthArray = [[NSMutableArray alloc]init];
            if ([[selectedYear substringToIndex:4] integerValue] == currentYear) {
                for (NSInteger i = 1 ; i <= currentMonth; i++) {
                    NSString *monthStr = [NSString stringWithFormat:@"%02ld月",(long)i];
                    [monthArray addObject:monthStr];
                }
            }else{
                for (NSInteger i = 1 ; i <= 12; i++) {
                    NSString *monthStr = [NSString stringWithFormat:@"%02ld月",(long)i];
                    [monthArray addObject:monthStr];
                }
            }
            selectecMonth = [NSString stringWithFormat:@"%02ld",(long)currentMonth];
            [pickerView reloadComponent:1];
        }else{
            selectecMonth = monthArray[row];
        }
    }else if(self.pickViewType == YXHeightType){
        self.bodyHeight = [NSString stringWithFormat:@"%.1ld",(row+50)];
    }else if(self.pickViewType == YXArrayType){
        self.bodyList = [NSString stringWithFormat:@"%@",self.listArr[row]];
    }
}
#pragma mark - Action

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    if (_pickViewType == YXBirthdayType) {
        NSInteger age = [SFTool getDayWithBirthdayDate:sender.date];
        if (age >= 0 && age < 120 * 365) {
            self.birthdayStr = [self.dateFormatter stringFromDate:sender.date];
        }
    }else{
        self.birthdayStr = [self.dateFormatter stringFromDate:sender.date];
        
    }
}
#pragma mark - Action

- (void)DoneClick
{
    if (self.pickViewType == YXBirthdayType) {
        self.resultString = self.birthdayStr;
    }else if (self.pickViewType == YXDateType) {
        self.yearAndMonthdateStr = [NSString stringWithFormat:@"%@-%@",selectedYear,selectecMonth];
        self.yearAndMonthdateStr = [self.yearAndMonthdateStr stringByReplacingOccurrencesOfString:@"年" withString:@""];
        self.yearAndMonthdateStr = [self.yearAndMonthdateStr stringByReplacingOccurrencesOfString:@"月" withString:@""];
        self.resultString = self.yearAndMonthdateStr;
    }else if (self.pickViewType == YXArrayType) {
        self.resultString = self.bodyList;
    }else if (self.pickViewType == YXHeightType) {
        self.resultString = self.bodyHeight;
    }
    [self removeFromSuperviews];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectNumer:)]) {
        [self.delegate didSelectNumer:self.resultString];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperviews];
}

- (void)appearAnimation
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RCOLOR(0, 0, 0, 0.3);
        self.showView.kaf_top = DEVICE_HEIGHT - self.showView.kaf_height;
    }];
}

- (void)removeFromSuperviews
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewDidRemove)]) {
        [self.delegate viewDidRemove];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RCOLOR(0, 0, 0, 0);
        self.showView.kaf_top = DEVICE_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
