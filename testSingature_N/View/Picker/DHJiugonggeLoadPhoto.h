//
//  DHJiugonggeLoadPhoto.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^YDYUIImagePickerControllerLoadPhotoHandler)(UIImage *image);
typedef void(^YDYUIImagePickerControllerLoadPhotoPHAssetHandler)(PHAsset *asset);

@interface DHJiugonggeLoadPhoto : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (void)takeAPicture;
@property (copy, nonatomic) YDYUIImagePickerControllerLoadPhotoHandler imageHandle;  //完成结果
@property (copy, nonatomic) YDYUIImagePickerControllerLoadPhotoPHAssetHandler assetHandler;  //完成结果

@property (nonatomic,assign)BOOL isCan;//返回图片链接
//block(返回图片链接)
@property (nonatomic, copy) void(^reloadDataCreatBlock)(NSString * url);

@end

NS_ASSUME_NONNULL_END
