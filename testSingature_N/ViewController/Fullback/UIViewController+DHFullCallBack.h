//
//  UIViewController+DHFullCallBack.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBackBlock)(UIBarButtonItem *backItem);
@interface UIViewController (DHFullCallBack)
@property(nonatomic,copy)CallBackBlock callBackBlock;
@end

NS_ASSUME_NONNULL_END
