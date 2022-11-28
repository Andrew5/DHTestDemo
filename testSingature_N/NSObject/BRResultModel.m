//
//  BRResultModel.m
//  BRPickerViewDemo
//
//  Created by renbo on 2019/10/2.
//  Copyright © 2019 irenb. All rights reserved.
//
//  最新代码下载地址：https://github.com/91renb/BRPickerView

#import "BRResultModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation BRResultModel

/// 判断两个对象是否相等
/// @param object 目标对象
- (BOOL)isEqual:(id)object {
    // 1.对象的地址相同
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[BRResultModel class]]) {
        return NO;
    }
    
    BRResultModel *model = (BRResultModel *)object;
    if (!model) {
        return NO;
    }
    // 2.对象的类型相同，且对象的各个属性相等
    BOOL isSameKey = (!self.key && !model.key) || [self.key isEqualToString:model.key];
    BOOL isSameValue = (!self.value && !model.value) || [self.value isEqualToString:model.value];
    
//    [[model mutableArrayValueForKey:@"array"] addObject:@"3"];
//    NSLog(@"%@",[model valueForKey:@"student.age"]);

    
    return isSameKey && isSameValue;
}
- (NSString *)description {
    NSLog(@"object address : %p \n", self);
    
    IMP nameIMP = class_getMethodImplementation(object_getClass(self), @selector(setValue:));
    IMP ageIMP = class_getMethodImplementation(object_getClass(self), @selector(setKey:));
    NSLog(@"object setName: IMP %p object setAge: IMP %p \n", nameIMP, ageIMP);
    
    Class objectMethodClass = [self class];
    Class objectRuntimeClass = object_getClass(self);
    Class superClass = class_getSuperclass(objectRuntimeClass);
    NSLog(@"objectMethodClass : %@, ObjectRuntimeClass : %@, superClass : %@ \n", objectMethodClass, objectRuntimeClass, superClass);
    
    NSLog(@"object method list \n");
    unsigned int count;
    Method *methodList = class_copyMethodList(objectRuntimeClass, &count);
    for (NSInteger i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        NSLog(@"method Name = %@\n", methodName);
    }
    
    return @"";
}
- (NSUInteger)hash {
    return [self.key hash] ^ [self.value hash];
}
- (NSString *)yyy{
    return @"111";
}
- (NSString *)ID {
    return _key;
}

- (NSString *)name {
    return _value;
}
- (NSString *)value {
    return   [_value stringByReplacingOccurrencesOfString:@"\'" withString:@""];
}
@end
