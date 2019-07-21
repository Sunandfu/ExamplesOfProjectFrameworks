//
//  SFHomeViewController.m
//  AppProjectDemo
//
//  Created by 史岁富 on 2018/5/28.
//  Copyright © 2018年 xiaofu. All rights reserved.
//

#import "SFHomeViewController.h"
#import "SDCycleScrollView.h"
#import "FMHorizontalMenuView.h"
#import "NotificationViewCell.h"
#import "TopImageViewViewCell.h"
#import "HomeViewCell.h"
#import "HomeCollectionViewCell.h"

@interface SFHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FMHorizontalMenuViewDelegate,FMHorizontalMenuViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

//DEBUG 数据
@property (nonatomic, strong) NSArray *topImageArray;
@property (nonatomic, strong) NSArray *notiTitleArray;

@property (nonatomic,strong) FMHorizontalMenuView *menuView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation SFHomeViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.topImageArray = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    self.notiTitleArray = @[@"测试数据 111",@"测试数据 222",@"测试数据 333",@"测试数据 444",@"测试数据 555",@"测试数据 666",@"测试数据 777"];
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, self.navigationAndStatuHeight)];
    self.animationView.backgroundColor = [UIColor whiteColor];
    self.animationView.alpha = 0.0;
    [self.navigationView addSubview:self.animationView];
    [self addSearchView];
    self.searchBar.backgroundColor = [UIColor clearColor];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.type = NavigationTypeClean;
}
- (UIView *)tableHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180)];
    headerView.backgroundColor = [UIColor greenColor];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.tag = 999;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headerView addSubview:cycleScrollView];
    cycleScrollView.imageURLStringsGroup = self.topImageArray;
    return headerView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-self.tabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _tableView.tableHeaderView = [self tableHeaderView];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeViewCell class]) bundle:nil] forCellReuseIdentifier:[HomeViewCell cellIdentifier]];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 2;
            break;
        case 5:
            return 1;
            break;
            
        default:
            return 45;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellID = @"UITableViewCell0ID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                [cell.contentView addSubview:self.menuView];
                [self.menuView reloadData];
            }
            return cell;}
            break;
        case 1:
        {
            static NSString *cellID = @"UITableViewCell1ID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                SDCycleScrollView *titlecCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, HEIGHT(36))];
                titlecCycleScrollView.delegate = self;
                titlecCycleScrollView.showPageControl = NO;
                titlecCycleScrollView.onlyDisplayText = YES;
                titlecCycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
                titlecCycleScrollView.titlesGroup = self.notiTitleArray;
                titlecCycleScrollView.tag = 666;
                [cell.contentView addSubview:titlecCycleScrollView];
                [titlecCycleScrollView disableScrollGesture];
            }
            return cell;}
            break;
        case 2:
        {
            HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeViewCell cellIdentifier] forIndexPath:indexPath];
            cell.miaoshaView.hidden = NO;
            return cell;
        }
            break;
        case 3:
        {
            HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeViewCell cellIdentifier] forIndexPath:indexPath];
            cell.miaoshaView.hidden = YES;
            return cell;
        }
            break;
        case 4:
        {
            HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeViewCell cellIdentifier] forIndexPath:indexPath];
            cell.miaoshaView.hidden = YES;
            return cell;
        }
            break;
        case 5:
        {
            static NSString *cellID = @"UITableViewCell5ID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.contentView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:self.collectionView];
            }
            return cell;}
            break;
            
        default:
        {
            static NSString *cellID = @"UITableViewCellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.textLabel.text = @"测试数据";
            return cell;}
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return HEIGHT(200);
            break;
        case 1:
            return HEIGHT(36);
            break;
        case 2:
            return HEIGHT(200);
            break;
        case 3:
            return HEIGHT(200);
            break;
        case 4:
            return HEIGHT(200);
            break;
        case 5:
            return HEIGHT(370);
            break;
            
        default:
            return 45;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    NSString *imageName = nil;
    switch (section) {
        case 0:
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 0);
            break;
        case 1:
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 0);
            break;
        case 2:
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 40);
            imageName = @"header0";
            break;
        case 3:
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 40);
            imageName = @"header1";
            break;
        case 4:
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 40);
            imageName = @"header2";
            break;
        case 5:
            headerView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 40);
            imageName = @"header3";
            break;
            
        default:
            break;
    }
    if (imageName) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 132, 25)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.center = headerView.center;
        [headerView addSubview:imageView];
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return CGFLOAT_MIN;
            break;
        case 1:
            return CGFLOAT_MIN;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 40;
            break;
        case 4:
            return 40;
            break;
        case 5:
            return 40;
            break;
            
        default:
            return CGFLOAT_MIN;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 10)];
    footerView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UICollectionViewDelegate
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat x=0;
        CGFloat y=0;
        CGFloat width=self.view.frame.size.width;
        CGFloat height=HEIGHT(370);
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:[HomeCollectionViewCell cellIdentifier]];
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
    return 4;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    HomeCollectionViewCell *cell=[HomeCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = WIDTH(160);
    CGFloat height = HEIGHT(170);
    return CGSizeMake(width, height);
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 20, 10, 20);
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
#pragma mark - SDCycleScrollViewDelegate
- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view{
    if (view.tag==999) {
        return [UINib nibWithNibName:NSStringFromClass([TopImageViewViewCell class]) bundle:nil];
    } else {
        return [UINib nibWithNibName:NSStringFromClass([NotificationViewCell class]) bundle:nil];
    }
}
- (NSString *)cellIdentifierForCycleScrollView:(SDCycleScrollView *)view{
    if (view.tag==999) {
        return [TopImageViewViewCell cellIdentifier];
    } else {
        return [NotificationViewCell cellIdentifier];
    }
}

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    if (view.tag==999) {
        TopImageViewViewCell *imagecell = (TopImageViewViewCell *)cell;
        [imagecell.currentImage sd_setImageWithURL:[NSURL URLWithString:self.topImageArray[index]] placeholderImage:[UIImage imageNamed:@"demo"]];
    } else {
        NotificationViewCell *labelcell = (NotificationViewCell *)cell;
        labelcell.notiLabel.text = self.notiTitleArray[index];
    }
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (cycleScrollView.tag==999) {
        NSLog(@"点击了第%ld张图片",index);
    } else {
        NSLog(@"点击了第%ld条通知",index);
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    if (cycleScrollView.tag==999) {
        NSLog(@"滚动到第%ld张图片",index);
    } else {
        NSLog(@"滚动到第%ld条通知",index);
    }
}
#pragma mark - FMHorizontalMenuView
- (FMHorizontalMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[FMHorizontalMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT(200))];
        _menuView.delegate = self;
        _menuView.dataSource = self;
        _menuView.currentPageDotColor = [UIColor colorWithRed:67 / 255.0 green:207 / 255.0 blue:119 / 255.0 alpha:1.0];
        _menuView.pageDotColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _menuView.pageControlBottomOffset = 10;
    }
    return _menuView;
}
#pragma mark === FMHorizontalMenuViewDataSource

//-(UINib *)customCollectionViewCellNibForHorizontalMenuView:(FMHorizontalMenuView *)view{
//    return [UINib nibWithNibName:@"FMCollectionViewCell" bundle:nil];
//}
//-(void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index horizontalMenuView:(FMHorizontalMenuView *)view{
//    FMCollectionViewCell *myCell = (FMCollectionViewCell*)cell;
//    myCell.kindLabel.text = @"测试";
//}
/**
 提供数据的数量
 */
-(NSInteger)numberOfItemsInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 14;
}

#pragma mark === FMHorizontalMenuViewDelegate
/**
 设置每页的行数
 */
-(NSInteger)numOfRowsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 2;
}

/**
 设置每页的列数
 */
-(NSInteger)numOfColumnsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 5;
}
/**
 当选项被点击回调
 */
-(void)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"您点击了第%ld个",index + 1);
}
/**
 当前菜单的title
 */
-(NSString *)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView titleForItemAtIndex:(NSInteger)index{
    NSLog(@"第%ld个 item 的标题",index + 1);
    return @"板材";
}
/**
 本地图片
 */
-(NSString *)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView localIconStringForItemAtIndex:(NSInteger)index{
    NSLog(@"第%ld个 item 的 icon",index + 1);
    return @"demo";
}
-(CGSize)iconSizeForHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return CGSizeMake(45, 45);
}
#pragma mark - ScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.offsetY;
    if (offset>180) {
        self.animationView.alpha = 1.0;
    } else {
        self.animationView.alpha = offset/self.navigationAndStatuHeight;
    }
}

@end
