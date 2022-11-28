//
//  DHJiugonggeLoadPhoto.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/7.
//

#import "DHJiugonggeLoadPhoto.h"
#import "AppDelegate.h"

@implementation DHJiugonggeLoadPhoto

- (void)takeAPicture {
    // 如果拍摄的摄像头可用
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        // 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置拍摄照片
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置使用手机的后置摄像头（默认使用后置摄像头）
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置使用手机的前置摄像头。
        //picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 设置拍摄的照片允许编辑
        picker.allowsEditing = NO;
        [[DHJiugonggeLoadPhoto getCurrentShowViewController] presentViewController:picker animated:YES completion:nil];
        
//        if (self.isCan) {
//            //定位
//            __weak typeof(self) weakSelf = self;
//            [self.locationModel startUpdatingLocation];
//            self.locationModel.doneHandle = ^{
//                AMapPOI *poi = weakSelf.locationModel.addressArray.firstObject;
//                weakSelf.strAddress = poi.address;
//                weakSelf.latitude = poi.location.latitude;
//                weakSelf.longitude = poi.location.longitude;
//                NSLog(@"定位地址为:%@,纬度:%f,经度:%f",poi.address,weakSelf.latitude,weakSelf.longitude);
//            };
//        }
    } else {
//        [PKProgressHUD pkShowErrorWithStatueTitle: @"相机无法使用"];
    }
}

#pragma mark - 图像选择控制器代理实现
// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info--->成功：%@", info);
    // 获取用户拍摄的是照片还是视频
    //是图片
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if (self.isCan) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self requestFileUploadWithImage:img];
//        });
//    }
   
    // 判断获取类型：图片，并且是刚拍摄的照片
    if ([mediaType isEqualToString:@"public.image"] && picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage *theImage =nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing])
        {
            // 获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
            
        }else {
            // 获取原始的照片
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        // 拍摄成功
        if (self.imageHandle != nil) {
            self.imageHandle(theImage);
        }
        
        __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取
        //通过存储图片到本地路径，顺便拿到Url
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            createdAssetID = [PHAssetChangeRequest            creationRequestForAssetFromImage:theImage].placeholderForCreatedAsset.localIdentifier;
            
            //                    print("createdAssetID:\(createdAssetID ?? "nil")")
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            //通过localIdentifier 拿到PHAsset对象//崩溃
            PHFetchResult * assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetID] options:nil];
            
            if (assets.firstObject != nil)
            {
                //这里拿到了PHAsset对象，往下操作就看自己的需求了
                if (self.assetHandler != nil) {
                    self.assetHandler(assets.firstObject);
                }
            }
        }];
    } else {
        if (self.imageHandle != nil) {
            self.imageHandle(nil);
        }
        if (self.assetHandler != nil) {
            self.assetHandler(nil);
        }
    }
    // 隐藏UIImagePickerController
    [picker dismissViewControllerAnimated:YES completion:^{
        //选择完图片后，顶部状态栏会消失，调用这个方法，让状态栏恢复
        [[DHJiugonggeLoadPhoto getCurrentShowViewController] setNeedsStatusBarAppearanceUpdate];
    }];
}
#pragma mark - 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"用户取消的拍摄！");
    
    if (self.imageHandle != nil) {
        self.imageHandle(nil);
    }
    if (self.assetHandler != nil) {
        self.assetHandler(nil);
    }
    // 隐藏UIImagePickerController
    [picker dismissViewControllerAnimated:YES completion:^{
        //选择完图片后，顶部状态栏会消失，调用这个方法，让状态栏恢复
        [[DHJiugonggeLoadPhoto getCurrentShowViewController] setNeedsStatusBarAppearanceUpdate];
    }];
}

//上传图片
- (void)requestFileUploadWithImage:(UIImage *)image{
    //上传中
//    [PKProgressHUD PKShowCanBeCancelStatueTitle:@"上传中"];
//    [self initOSSUpload:image];
}


//获取当前正在显示的控制器
+ (UIViewController *)getCurrentShowViewController {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    if ([rootViewController isMemberOfClass:[UIViewController class]]) {
        return rootViewController;
    }
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naviVC = (UINavigationController *)rootViewController;
        return naviVC.visibleViewController;
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootViewController;
        UIViewController *seleViewController = tabBarVC.selectedViewController;
        if ([seleViewController isMemberOfClass:[UIViewController class]]) {
            return seleViewController;
        }
        if ([seleViewController isMemberOfClass:[UINavigationController class]] || [seleViewController isMemberOfClass:[UINavigationController class]]) {
            UINavigationController *naviVC = (UINavigationController *)seleViewController;
            //                如果还是UITabBarController（奇趣商城），继续遍历
            if ([naviVC.visibleViewController isKindOfClass:[UITabBarController class]]) {
                return [self getCurrentVC:(UITabBarController *)naviVC.visibleViewController];
            }
            return naviVC.visibleViewController;
        }
        else {  // (后来加的)如果不是就返回一个系统的导航控制器
            UINavigationController *naviVC = (UINavigationController *)seleViewController;
            return naviVC.visibleViewController;
        }
    }else {
        return rootViewController;
    }
}
+ (UIViewController *)getCurrentVC:(UITabBarController *)tabbarController{
    
    UIViewController *seleViewController = tabbarController.selectedViewController;
    
    if ([seleViewController isMemberOfClass:[UIViewController class]]) {
        return seleViewController;
    }
    
    if ([seleViewController isMemberOfClass:[UINavigationController class]] || [seleViewController isMemberOfClass:[UINavigationController class]]) {
        
        UINavigationController *naviVC = (UINavigationController *)seleViewController;
        
        if ([naviVC.visibleViewController isKindOfClass:[UITabBarController class]]) {
            
            return [self getCurrentVC:(UITabBarController *)naviVC.visibleViewController];
        }
        
        return naviVC.visibleViewController;
    }
    else {  // (后来加的)如果不是就返回一个系统的导航控制器
        
        UINavigationController *naviVC = (UINavigationController *)seleViewController;
        return naviVC.visibleViewController;
    }
}
@end
