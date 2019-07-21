//
//  FYAlbumManager.m
//  FYAlbumDemo
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "FYAlbumManager.h"
#import "FYPhotoCollectionsViewController.h"
#import "FadeOutView.h"


@implementation FYAlbumManager

+ (instancetype)shareAlbumManager{
    static FYAlbumManager * albumManager ;
    if (albumManager) {
        return albumManager;
    }
    albumManager =[[FYAlbumManager alloc]init];
    return albumManager;
}
- (void)showInView:(UIViewController *)view{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action=[ UIAlertAction  actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机");
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        UIImagePickerController * picker=[[UIImagePickerController alloc]init];
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        picker.allowsEditing = NO;
                        picker.delegate = self;
                        [view presentViewController:picker animated:YES completion:nil];
                    } else {
                        showFadeOutView(@"相机不可用哦", NO, 1);
                    }
                } else {
                    showFadeOutView(@"请在设置中允许相机权限", NO, 1);
                }
            });
        }];
    }];
    
    UIAlertAction * action2=[ UIAlertAction  actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    if ([self permissionTypePhotoAction]) {
                        FYPhotoCollectionsViewController * collection =[[FYPhotoCollectionsViewController alloc]init];
                        collection.maxSelected = self.maxSelect;
                        UINavigationController * na=[[UINavigationController alloc]initWithRootViewController:collection];
                        collection.complate = ^(NSArray * array){
                            self.complate?self.complate(array):nil;
                        };
                        [view presentViewController:na animated:YES completion:nil];
                    } else {
                        showFadeOutView(@"请允许相册权限", NO, 1);
                    }
                } else {
                    showFadeOutView(@"请在设置中允许相册权限", NO, 1);
                }
            });
        }];
        
    }];
    UIAlertAction * action3=[ UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [view presentViewController:alert animated:YES completion:nil];
}
/*
 *相册权限
 */
- (BOOL)permissionTypePhotoAction{
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    if (photoStatus == PHAuthorizationStatusAuthorized) {
        return YES;
    } else {
        return NO;
    }
}

/*
 *相机权限
 */
- (BOOL)permissionTypeCameraAction{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - pickdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.complate?self.complate(@[image]):nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
