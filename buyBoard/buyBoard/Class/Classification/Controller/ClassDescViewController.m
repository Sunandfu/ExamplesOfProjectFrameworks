//
//  ClassDescViewController.m
//  buyBoard
//
//  Created by lurich on 2019/7/18.
//  Copyright © 2019 lurich. All rights reserved.
//

#import "ClassDescViewController.h"
#import "MultilevelMenu.h"

@interface ClassDescViewController ()

@end

@implementation ClassDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray * lis=[NSMutableArray arrayWithCapacity:0];
    
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
    NSInteger countMax=20;
    for (int i=0; i<countMax; i++) {
        
        rightMeun * meun=[[rightMeun alloc] init];
        meun.meunName=[NSString stringWithFormat:@"装饰板材%d",i];
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        for ( int j=0; j <countMax+1; j++) {
            
            rightMeun * meun1=[[rightMeun alloc] init];
            meun1.meunName=[NSString stringWithFormat:@"品配标签%d-%d",i,j];
            
            [sub addObject:meun1];
            
            //meun.meunNumber=2;
            
            NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
            if (j%2==0) {
                
                for ( int z=0; z <countMax+2; z++) {
                    
                    rightMeun * meun2=[[rightMeun alloc] init];
                    meun2.meunName=[NSString stringWithFormat:@"马六甲生态板新款预售%d-%d",j,z];
                    
                    [zList addObject:meun2];
                    
                }
            }
            
            meun1.nextArray=zList;
        }
        
        
        meun.nextArray=sub;
        [lis addObject:meun];
    }
    
    CGFloat tabBarHeight;
    if (self.tabBarController) {
        tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    } else {
        tabBarHeight = 0;
    }
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (StatusRect.size.height == 40) {
        StatusRect = CGRectMake(0, 0, StatusRect.size.width, 20);
    }
    CGFloat statusBarHeight = StatusRect.size.height;
    CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    CGFloat navigationAndStatuHeight = statusBarHeight + navigationBarHeight;
    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-navigationAndStatuHeight-tabBarHeight) WithData:lis withSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
        
        NSLog(@"点击的 菜单%@",info.meunName);
    }];
    
    //    view.leftSelectColor=[UIColor greenColor];
    //  view.leftSelectBgColor=[UIColor redColor];
//    view.isRecordLastScroll=YES;
    [self.view addSubview:view];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
