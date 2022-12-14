//
//  Character.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/10.
//

#import <Foundation/Foundation.h>
#import "AttackStrategy.h"
NS_ASSUME_NONNULL_BEGIN
// 人物类
@interface Character : NSObject
@property (nonatomic, strong) AttackStrategy *strategy;
- (void)attack;
@end

NS_ASSUME_NONNULL_END
