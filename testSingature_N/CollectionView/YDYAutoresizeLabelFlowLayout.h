//
//  YDYAutoresizeLabelFlowLayout.h
//  testSingature
//
//  Created by jabraknight on 2022/3/8.
//  Copyright © 2022 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol XDAutoresizeLabelFlowLayoutDataSource <NSObject>

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface YDYAutoresizeLabelFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id <XDAutoresizeLabelFlowLayoutDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
