//
//  Config.h
//  AppProjectDemo
//
//  Created by 史岁富 on 2018/5/28.
//  Copyright © 2018年 xiaofu. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width

#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IPhone4s CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size)

#define IPad CGSizeEqualToSize(CGSizeMake(768, 1024), [UIScreen mainScreen].bounds.size)

#define IPadMini CGSizeEqualToSize(CGSizeMake(768, 1024), [UIScreen mainScreen].bounds.size)

#define IPadPro CGSizeEqualToSize(CGSizeMake(1024, 1366), [UIScreen mainScreen].bounds.size)

#define IPhone5 CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size)

//IPhone6 IPhone7 IPhone8 的逻辑分辨率相同
#define IPhone6 CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size)

//IPhone6P IPhone7P IPhone8P 的逻辑分辨率相同
#define IPhone6p CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size)

//IPhoneX IPhoneXS 的逻辑分辨率相同
#define IPhoneX CGSizeEqualToSize(CGSizeMake(375, 812), [UIScreen mainScreen].bounds.size)

//IPhoneXR IPhoneXSMax 的逻辑分辨率相同
#define IPhoneXR CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size)

#define ScaleWide ((IPhone5 || IPhone4s) ? 0.8533 : ((IPhone6 || IPhoneX) ? 1.0000 : ((IPhone6p || IPhoneXR) ? 1.1040 : ((IPad || IPadMini) ? 2.0480 : (IPadPro ? 2.7036 : 1.0000)))))

#define WIDTH(W)   ScaleWide * W

#define HEIGHT(H)    ScaleWide * H

#define HFont(A)     ScaleWide * (A)

#define TOKEN [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]
#define USERID [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"]

//Appdelegate
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
//通知中心
#define KNotificationCenter [NSNotificationCenter defaultCenter]
//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

#endif /* Config_h */
