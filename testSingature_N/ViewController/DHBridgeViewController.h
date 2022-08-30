//
//  DHBridgeViewController.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import <UIKit/UIKit.h>
#import "DHBridgeDelegate.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshHintLabelBlock)(NSString *hintString);

@interface DHBridgeViewController : UIViewController<DHBridgeDelegate>
@property (nonatomic, copy) RefreshHintLabelBlock hintBlock;
@property (nonatomic, copy) void(^refreshHintLabelBlock) (NSString *hintString);

@property (nonatomic, weak) id<DHBridgeDelegate> secondDelegate;

@end

NS_ASSUME_NONNULL_END
