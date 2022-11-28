//
//  YDYSalesRecordDetailInfoListInfoItemCell.h
//  meetCRM
//
//  Created by 史晓义 on 2022/3/8.
//  Copyright © 2022 edianyun. All rights reserved.
//

#import <UIKit/UIKit.h>
//陪访记录cell的图片cell
NS_ASSUME_NONNULL_BEGIN
typedef void(^YDYSalesRecordDetailInfoListInfoItemCellDeleteHandler)(void);

@interface YDYSalesRecordDetailInfoListInfoItemCell : UICollectionViewCell

@property (strong , nonatomic) UIImageView *icon;
@property (strong, nonatomic) UIButton *deleteButton;//默认隐藏

@property (copy, nonatomic) YDYSalesRecordDetailInfoListInfoItemCellDeleteHandler deleteHandle;  //删除

@end

NS_ASSUME_NONNULL_END
