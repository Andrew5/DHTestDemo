//
//  SystemAuthorityTool.m
//  SystemAuthority
//
//  Created by mac on 2021/9/21.
//

#import "SystemAuthorityTool.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIDevice.h>
#import <Photos/Photos.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@import Contacts;

static SystemAuthorityTool * shareManager = nil;
static dispatch_once_t onceToken; //拿到函数体外,成为全局的.

@interface SystemAuthorityTool()<CLLocationManagerDelegate>


@property (strong, nonatomic) CLLocationManager* location;

@end

@implementation SystemAuthorityTool

+ (instancetype)shared{
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}



#pragma mark ===============获取麦克风权限===============
- (void)getMicrophonePermissionStatus{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];

      switch (status) {
          case AVAuthorizationStatusDenied:
          case AVAuthorizationStatusRestricted:
          {// 被拒绝
              if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                  [self.delegate systemAuthorityTool:self Type:MICROPHONE_PERMISSION Status:NO_AUTHORIZATION];
              }
          }
              break;
          case AVAuthorizationStatusNotDetermined:
          {// 没弹窗
              [self requestMicroPhoneAuth];
              
              if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                  [self.delegate systemAuthorityTool:self Type:MICROPHONE_PERMISSION Status:NO_APPLICATION];
              }
          }
              break;
          case AVAuthorizationStatusAuthorized:
          {// 有授权
              if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                  [self.delegate systemAuthorityTool:self Type:MICROPHONE_PERMISSION Status:AUTHORIZED];
              }
          }
              break;

          default:
              break;
      }
}

- (void)requestMicroPhoneAuth
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        [self getMicrophonePermissionStatus];
    }];
}

#pragma mark ===============获取相机权限===============
- (void)getCameraPermissionStatus {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

      switch (status) {
          case AVAuthorizationStatusDenied:
          case AVAuthorizationStatusRestricted:
          {// 被拒绝
              if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                  [self.delegate systemAuthorityTool:self Type:CAMERA_PERMISSION Status:NO_AUTHORIZATION];
              }
          }
              break;
          case AVAuthorizationStatusNotDetermined:
          {// 没弹窗
              [self requestCameraAuth];
              
              if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                  [self.delegate systemAuthorityTool:self Type:CAMERA_PERMISSION Status:NO_APPLICATION];
              }
          }
              break;
          case AVAuthorizationStatusAuthorized:
          {// 有授权
              if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                  [self.delegate systemAuthorityTool:self Type:CAMERA_PERMISSION Status:AUTHORIZED];
              }
          }
              break;

          default:
              break;
      }
}

- (void)requestCameraAuth
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        [self getCameraPermissionStatus];
    }];
}

#pragma mark ===============获取相册权限===============
- (void)getAlbumPermissionStatus{
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat version = [phoneVersion floatValue];
    
    if (version >= 10.0) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (status) {
                    case PHAuthorizationStatusDenied:
                    case PHAuthorizationStatusRestricted:
                    {// 被拒绝
                        if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                            [self.delegate systemAuthorityTool:self Type:ALBUM_PERMISSION Status:NO_AUTHORIZATION];
                        }
                    }
                        break;
                    
                    case PHAuthorizationStatusNotDetermined:
                    {// 没弹窗
                        if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                            [self.delegate systemAuthorityTool:self Type:ALBUM_PERMISSION Status:NO_APPLICATION];
                        }
                        [self requestAlbumAuth];
                    }
                        break;
                    case PHAuthorizationStatusAuthorized:
                    {// 有授权
                        if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                            [self.delegate systemAuthorityTool:self Type:ALBUM_PERMISSION Status:AUTHORIZED];
                        }
                    }
                        break;
                    default:
                        break;
                }
            });
        }];
    }else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
        switch (status) {
            case PHAuthorizationStatusDenied:
            case PHAuthorizationStatusRestricted:
            {// 被拒绝
                if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                    [self.delegate systemAuthorityTool:self Type:ALBUM_PERMISSION Status:NO_AUTHORIZATION];
                }
            }
                break;
            
            case PHAuthorizationStatusNotDetermined:
            {// 没弹窗
                if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                    [self.delegate systemAuthorityTool:self Type:ALBUM_PERMISSION Status:NO_APPLICATION];
                }
            }
                break;
            case PHAuthorizationStatusAuthorized:
            {// 有授权
                if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                    [self.delegate systemAuthorityTool:self Type:ALBUM_PERMISSION Status:AUTHORIZED];
                }
            }
                break;
            default:
                break;
        }
    }
    
}
- (void)requestAlbumAuth{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        [self getAlbumPermissionStatus];
    }];
}


#pragma mark ===============获取位置权限===============
- (void)getLocationPermissionStatus {

    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat version = [phoneVersion floatValue];
    
    if (version >= 13 && status == kCLAuthorizationStatusNotDetermined) {
        self.location = [[CLLocationManager alloc] init];
        self.location.delegate = self;
        [self.location requestWhenInUseAuthorization];

    }

    switch (status) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {// 被拒绝
            if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                [self.delegate systemAuthorityTool:self Type:LOCATION_PERMISSION Status:NO_AUTHORIZATION];
            }
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {// 没弹窗
    
            if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                [self.delegate systemAuthorityTool:self Type:LOCATION_PERMISSION Status:NO_APPLICATION];
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {// 有授权
            if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                [self.delegate systemAuthorityTool:self Type:LOCATION_PERMISSION Status:AUTHORIZED];
            }
        }
            break;

        default:
            break;
    }

}

#pragma mark ===============CLLocationDelegate===============
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (status) {
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted:
            {// 被拒绝
                if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                    [self.delegate systemAuthorityTool:self Type:LOCATION_PERMISSION Status:NO_AUTHORIZATION];
                }
            }
                break;
            case kCLAuthorizationStatusNotDetermined:
            {// 没弹窗
        
                if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                    [self.delegate systemAuthorityTool:self Type:LOCATION_PERMISSION Status:NO_APPLICATION];
                }
            }
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            {// 有授权
                if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                    [self.delegate systemAuthorityTool:self Type:LOCATION_PERMISSION Status:AUTHORIZED];
                }
            }
                break;

            default:
                break;
        }
    });
    if (status != kCLAuthorizationStatusNotDetermined) {
        [self getLocationPermissionStatus];
    }
}


/// 获取通讯录权限
- (void)getAddressBookPermissionStatus {
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];

    switch (status) {

        
        case CNAuthorizationStatusAuthorized:{
            NSLog(@"Authorized:");
            if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                [self.delegate systemAuthorityTool:self Type:ADDRESS_BOOK Status:AUTHORIZED];
            }
        }
            break;

        case CNAuthorizationStatusDenied:{
            NSLog(@"Denied");
            if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                [self.delegate systemAuthorityTool:self Type:ADDRESS_BOOK Status:NO_AUTHORIZATION];
            }
        }
            break;
        case CNAuthorizationStatusRestricted:{
            NSLog(@"Restricted");
            if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                [self.delegate systemAuthorityTool:self Type:ADDRESS_BOOK Status:NO_AUTHORIZATION];
            }
        }
            break;
        case CNAuthorizationStatusNotDetermined:{

            NSLog(@"NotDetermined");
            CNContactStore *contactStore = [[CNContactStore alloc] init];

            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {

                if (granted) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                        [self.delegate systemAuthorityTool:self Type:ADDRESS_BOOK Status:AUTHORIZED];
                    }
                }else{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(systemAuthorityTool:Type:Status:)]) {
                        [self.delegate systemAuthorityTool:self Type:ADDRESS_BOOK Status:NO_AUTHORIZATION];
                    }
                }

            }];

        }
            break;
        default:
            break;
    }
   
}


@end
