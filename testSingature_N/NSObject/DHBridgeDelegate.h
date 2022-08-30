//
//  DHBridgeDelegate.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DHBridgeDelegate <NSObject>
-(void)refreshHintLabel:(NSString *)hintString;
@end

NS_ASSUME_NONNULL_END
