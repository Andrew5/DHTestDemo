//
//  YDYContactsCollectionCell.h
//  meetCRM
//
//  Created by jabraknight on 2022/2/24.
//  Copyright © 2022 edianyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CollectionCell)(NSInteger personid);

@interface YDYContactsCollectionCell : UICollectionViewCell
/** 联系人点击事件 */
@property (nonatomic, copy) CollectionCell buttonClick;

/** <#copy属性注释#> */
@property (nonatomic, copy) NSString *nsyerrt;
@end

NS_ASSUME_NONNULL_END
