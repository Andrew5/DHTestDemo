//
//  AttackStrategy.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttackStrategy : NSObject
// 首先，定义一个抽象的策略类，它包含了一个抽象的攻击方法：
- (void)attack;

@end

NS_ASSUME_NONNULL_END
