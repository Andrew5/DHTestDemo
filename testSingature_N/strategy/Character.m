//
//  Character.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/10.
//

#import "Character.h"

@implementation Character
- (void)attack
{
    // 使用选择的策略进行攻击
    [self.strategy attack];
}

@end
