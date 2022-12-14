//
//  NSObject+Aspects.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/10.
//

#import "NSObject+Aspects.h"
#import "AspectProxy.h"

@implementation NSObject (Aspects)
+ (void)load
{
    // 为每个类动态地创建一个转发对象
    AspectProxy *proxy = [AspectProxy new];

    // 获取类的元类
    Class metaClass = object_getClass(self);

    // 为类的元类设置转发对象
    object_setClass(self, metaClass);
}
@end
