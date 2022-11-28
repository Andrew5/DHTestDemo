//
//  YDYUIImagePickerControllerLoadPhoto.h
//  meetCRM
//
//  Created by 史晓义 on 2022/2/25.
//  Copyright © 2022 edianyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^YDYUIImagePickerControllerLoadPhotoHandler)(UIImage *image);
typedef void(^YDYUIImagePickerControllerLoadPhotoPHAssetHandler)(PHAsset *asset);

@interface YDYUIImagePickerControllerLoadPhoto : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)takeAPicture;
@property (copy, nonatomic) YDYUIImagePickerControllerLoadPhotoHandler imageHandle;  //完成结果
@property (copy, nonatomic) YDYUIImagePickerControllerLoadPhotoPHAssetHandler assetHandler;  //完成结果
@property (nonatomic, copy) void(^reloadDataCreatBlock)(UIImage *image);
@end

NS_ASSUME_NONNULL_END
