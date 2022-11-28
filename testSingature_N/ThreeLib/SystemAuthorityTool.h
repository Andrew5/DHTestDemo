//
//  SystemAuthorityTool.h
//  SystemAuthority
//
//  Created by mac on 2021/9/21.
//

#import <Foundation/Foundation.h>

#define ToolManager [SystemAuthorityTool shared]


NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    NO_AUTHORIZATION = 1,///没授权
    AUTHORIZED = 2,///授权
    NO_APPLICATION = 3,///还没有申请
} PERMISSION_STATUS;

typedef enum : NSUInteger {
    MICROPHONE_PERMISSION = 1,///麦克风
    CAMERA_PERMISSION = 2,///相机
    LOCATION_PERMISSION = 3,///定位
    ALBUM_PERMISSION = 4,///相册
    ADDRESS_BOOK = 5,///相册address book
} PERMISSION_TYPE;


@class SystemAuthorityTool;
@protocol SystemAuthorityToolDelegate <NSObject>

- (void)systemAuthorityTool:(SystemAuthorityTool *)tool Type:(PERMISSION_TYPE)type Status:(PERMISSION_STATUS)status;

@end

@interface SystemAuthorityTool : NSObject

@property (nonatomic, weak)id <SystemAuthorityToolDelegate>delegate;

+ (instancetype)shared;

/// 获取麦克风权限
- (void)getMicrophonePermissionStatus;

/// 获取相机权限
- (void)getCameraPermissionStatus;

/// 获取相册权限
- (void)getAlbumPermissionStatus;

/// 获取定位权限
- (void)getLocationPermissionStatus;

/// 获取通讯录权限
- (void)getAddressBookPermissionStatus;

@end

NS_ASSUME_NONNULL_END
