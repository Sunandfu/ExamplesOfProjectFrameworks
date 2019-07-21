//
//  CustomizedViewController.m
//  buyBoard
//
//  Created by lurich on 2019/7/18.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "CustomizedViewController.h"
#import "CustomizedViewCell.h"
#import "CustomModel.h"
#import "YXBottomPickdateweightView.h"
#import "FYAlbumManager.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ChooseImageViewCell.h"
#import "CameraImageViewCell.h"

@interface CustomizedViewController ()<UITableViewDelegate,UITableViewDataSource,YXBottomPickerViewProtocol,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    BOOL isAdd;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YXBottomPickdateweightView *bottomPickView;
@property (strong, nonatomic) UICollectionView *collectionView;//容器视图
@property (nonatomic, strong) NSMutableArray *chooseImgArray;

@end

@implementation CustomizedViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.type = NavigationTypeBlack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制";
    isAdd = NO;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.chooseImgArray = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
    [self getSettingData];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.navigationView];
//    [self.navigationView sendSubviewToBack:self.tableView];
}
- (void)getSettingData{
    NSMutableArray *sectionArray0 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray0 addObject:[self modelWithName:@"商品分类" Desc:@"" IsImportant:NO Placeholder:@"请选择" IsChoose:YES]];
    NSMutableArray *sectionArray1 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray1 addObject:[self modelWithName:@"芯板结构" Desc:@"" IsImportant:NO Placeholder:@"请选择" IsChoose:YES]];
    [sectionArray1 addObject:[self modelWithName:@"功能" Desc:@"" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray1 addObject:[self modelWithName:@"品配" Desc:@"" IsImportant:NO Placeholder:@"请输入" IsChoose:NO]];
    NSMutableArray *sectionArray2 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray2 addObject:[self modelWithName:@"长" Desc:@"(mm)" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray2 addObject:[self modelWithName:@"宽" Desc:@"(mm)" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray2 addObject:[self modelWithName:@"高" Desc:@"(mm)" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    NSMutableArray *sectionArray3 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray3 addObject:[self modelWithName:@"芯板材质" Desc:@"" IsImportant:YES Placeholder:@"请选择" IsChoose:YES]];
    [sectionArray3 addObject:[self modelWithName:@"表面工艺" Desc:@"" IsImportant:YES Placeholder:@"请选择" IsChoose:YES]];
    [sectionArray3 addObject:[self modelWithName:@"环保等级" Desc:@"" IsImportant:YES Placeholder:@"请选择" IsChoose:YES]];
    NSMutableArray *sectionArray4 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray4 addObject:[self modelWithName:@"定制数量" Desc:@"(张)" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray4 addObject:[self modelWithName:@"交货周期" Desc:@"(天)" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray4 addObject:[self modelWithName:@"包装方式" Desc:@"" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    NSMutableArray *sectionArray5 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray5 addObject:[self modelWithName:@"公司名称" Desc:@"" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray5 addObject:[self modelWithName:@"收货人" Desc:@"" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    [sectionArray5 addObject:[self modelWithName:@"联系电话" Desc:@"" IsImportant:YES Placeholder:@"请输入" IsChoose:NO]];
    NSMutableArray *sectionArray6 = [NSMutableArray arrayWithCapacity:0];
    [sectionArray6 addObject:[self modelWithName:@"上传照片" Desc:@"" IsImportant:NO Placeholder:@"" IsChoose:YES]];
    [self.dataArray addObject:sectionArray0];
    [self.dataArray addObject:sectionArray1];
    [self.dataArray addObject:sectionArray2];
    [self.dataArray addObject:sectionArray3];
    [self.dataArray addObject:sectionArray4];
    [self.dataArray addObject:sectionArray5];
    [self.dataArray addObject:sectionArray6];
}
- (CustomModel *)modelWithName:(NSString *)name Desc:(NSString *)desc IsImportant:(BOOL)isImportant Placeholder:(NSString *)placeholder IsChoose:(BOOL)isChoose{
    CustomModel *model = [[CustomModel alloc] init];
    model.name = name;
    model.desc = desc;
    model.isImportant = isImportant;
    model.placeholder = placeholder;
    model.isChoose = isChoose;
    return model;
}

- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 80)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"fff6ce"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, headerView.kaf_width-40, headerView.kaf_height-20)];
//    label.textColor = [UIColor colorWithHexColor:@"da4800" andOpacity:1.0];
    label.numberOfLines = 0;
    label.text = @"定制说明：定制产品双方在签订协议后，由订货方预付\n货款的30%作为订金，待发货后支付剩余款项。";
//    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    [headerView addSubview:label];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 10;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12 weight:UIFontWeightLight],NSForegroundColorAttributeName: [UIColor colorWithHexColor:@"da4800" andOpacity:1.0],NSParagraphStyleAttributeName:paragraphStyle}];
    label.attributedText = string;
    return headerView;
}
- (UIView *)tableViewFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 80)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *button = [SFTool createButtonWithTitle:@"确认提交" frame:CGRectMake(20, 20, DEVICE_WIDTH-40, footerView.kaf_height-40) target:self selector:@selector(submitForm)];
    [button setBackgroundColor:THEME_COLOR];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [footerView addSubview:button];
    return footerView;
}
- (TPKeyboardAvoidingTableView *)tableView{
    if(!_tableView){
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self tableViewHeaderView];
        _tableView.tableFooterView = [self tableViewFooterView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomizedViewCell class]) bundle:nil] forCellReuseIdentifier:[CustomizedViewCell cellIdentifier]];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChooseImageViewCell class]) bundle:nil] forCellReuseIdentifier:[ChooseImageViewCell cellIdentifier]];
    }
    return _tableView;
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"numberOfSectionsInTableView = %ld",self.dataArray.count);
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *row = self.dataArray[section];
    return row.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count-1) {
        ChooseImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChooseImageViewCell cellIdentifier] forIndexPath:indexPath];
        if (!isAdd) {
            isAdd = YES;
            [cell.backView addSubview:self.collectionView];
        } else {
            NSLog(@"cellForRowAtIndexPath***%@",NSStringFromCGRect(self.collectionView.frame));
        }
        return cell;
    } else {
        CustomizedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CustomizedViewCell cellIdentifier] forIndexPath:indexPath];
        NSArray *rowArray = self.dataArray[indexPath.section];
        CustomModel *model = rowArray[indexPath.row];
        model.tagString = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
        cell.contentField.tag = [model.tagString integerValue];
        [cell.contentField addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventValueChanged];
        [cell drawCellWithModel:model];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==self.dataArray.count-1) {
        FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
        manager.maxSelect = 10;
        WeakSelf(self);
        manager.complate = ^(NSArray *array){
            [weakself.chooseImgArray addObjectsFromArray:array];
            [weakself.collectionView reloadData];
            dispatch_async(dispatch_get_main_queue(),^{
                CGFloat height = weakself.collectionView.collectionViewLayout.collectionViewContentSize.height;
                //刷新完成，其他操作
                weakself.collectionView.frame = CGRectMake(0, 0, DEVICE_WIDTH-160, height>HEIGHT(56)?height:HEIGHT(56));
                [weakself.tableView beginUpdates];
                [weakself.tableView endUpdates];
                [weakself.tableView beginUpdates];
                [weakself.tableView endUpdates];
            });
        };
        [manager showInView:self];
    } else {
        [self.view endEditing:YES];
        NSArray *rowArray = self.dataArray[indexPath.section];
        CustomModel *model = rowArray[indexPath.row];
        if (!model.isChoose) {
            return;
        }
        self.bottomPickView.listArr = @[@"选项一",@"选项二",@"选项三"];
        self.bottomPickView.listTitle = [NSString stringWithFormat:@"请选择%@",model.name];
        self.bottomPickView.listDetail = @"";
        self.bottomPickView.bodyList = @"默认选项是0";
        self.bottomPickView.pickViewType = YXArrayType;
        [self.window addSubview:self.bottomPickView];
        [self.bottomPickView appearAnimation];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count-1) {
        return self.collectionView.contentSize.height>HEIGHT(56)?self.collectionView.contentSize.height+30:HEIGHT(86);
    } else {
        return HEIGHT(40);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *lineview= [[UIView alloc] initWithFrame:CGRectMake(20, 13, 3, 14)];
    lineview.backgroundColor = THEME_COLOR;
    [headerView addSubview:lineview];
    NSString *headerTitle;
    switch (section) {
        case 1:
            headerTitle = @"标准";
            break;
        case 2:
            headerTitle = @"尺寸";
            break;
        case 3:
            headerTitle = @"属性";
            break;
        case 4:
            headerTitle = @"要求";
            break;
        case 5:
            headerTitle = @"联系方式";
            break;
            
        default:
            headerTitle = @"";
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 0);
            break;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lineview.kaf_right+10, 0, headerView.kaf_width-lineview.kaf_right-40, headerView.kaf_height)];
    label.text = headerTitle;
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    label.textColor = THEME_COLOR;
    [headerView addSubview:label];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0 || section==6) {
        return CGFLOAT_MIN;
    } else {
        return 40;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 10)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)textFieldEdit:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    
}
- (void)submitForm{
    NSLog(@"提交表单");
}
#pragma mark - CollectionViewDelegate
//初始化容器视图
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat x=0;
        CGFloat y=0;
        CGFloat width = DEVICE_WIDTH-160;;
        CGFloat height = 53;
        //创建布局对象
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;    //创建容器视图
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:layout];
        _collectionView.delegate=self;//设置代理
        _collectionView.dataSource=self;//设置数据源
        _collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
        //注册容器视图中显示的方块视图
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CameraImageViewCell class]) bundle:nil] forCellWithReuseIdentifier:[CameraImageViewCell cellIdentifier]];
    }
    return _collectionView;
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.chooseImgArray.count;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    CameraImageViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[CameraImageViewCell cellIdentifier] forIndexPath:indexPath];
    cell.cameraImg.image = self.chooseImgArray[indexPath.item];
    cell.delegateBtn.tag = indexPath.item;
    [cell.delegateBtn addTarget:self action:@selector(delegateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 60;
    CGFloat height = 60;
    return CGSizeMake(width, height);
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
- (void)delegateBtnClick:(UIButton *)sender{
    [self.chooseImgArray removeObjectAtIndex:sender.tag];
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(),^{
        CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
        self.collectionView.frame = CGRectMake(0, 0, DEVICE_WIDTH-160, height>HEIGHT(56)?height:HEIGHT(56));
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    });
}
#pragma mark - YXBottomPickdateweightView
- (YXBottomPickdateweightView *)bottomPickView
{
    if (!_bottomPickView) {
        _bottomPickView = [[YXBottomPickdateweightView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _bottomPickView.delegate = self;
    }
    return _bottomPickView;
}

- (void)didSelectNumer:(NSString*)result{
    
}

@end
