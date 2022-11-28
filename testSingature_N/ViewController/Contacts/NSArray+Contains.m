//
//  NSArray+Contains.m
//  Contacts
//
//  Created by siguoxi on 2017/7/24.
//  Copyright © 2017年 北京玄铁科技有限公司. All rights reserved.
//

#import "NSArray+Contains.h"

@implementation NSArray (Contains)
- (BOOL)contains:(NSDictionary *)anObject
{
    __block BOOL contains = NO;
    [self enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"cell"] isEqualToString:anObject[@"cell"]]) {
            *stop = YES;
            contains = YES;
        }
    }];
    return contains;
}
@end
