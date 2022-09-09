//
//  WKAutoDictionary.m
//  testSingature
//
//  Created by jabraknight on 2021/11/30.
//  Copyright © 2021 zk. All rights reserved.
//

#import "WKAutoDictionary.h"
#import <objc/runtime.h>
@interface WKAutoDictionary ()
@property (nonatomic, strong) NSMutableDictionary *backingStore;
@end
@implementation WKAutoDictionary
@dynamic string, number, date, opaqueObject;
- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [NSMutableDictionary dictionary];
    }
    return self;
}
/*
 * 找不到sel首先会进入
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selString = NSStringFromSelector(sel);
    if ([selString hasPrefix:@"set"]) {//说明调用的时set方法
        class_addMethod(self,  //class_addMethod 可以向类中动态添加方法
                        sel,
                        (IMP)autoDictionarySetter,//函数指针类型，指向待添加的方法
                        "v@:@");// 表示待添加方法的“类型编码”
    }else {
        class_addMethod(self,
                        sel,
                        (IMP)autoDictionaryGetter,
                        "@@:");
    }
    return YES;
}

void autoDictionarySetter (id self, SEL _cmd, id value) {
    //获取当前self的字典
    WKAutoDictionary *typedSelf = (WKAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *selString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selString mutableCopy];
    //删除set方法的“:”
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    //删除 “set”
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    //让第一个字符小写
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    if (value) {
        [backingStore setObject:value forKey:key];
    }else {
        [backingStore removeObjectForKey:key];
    }
}

id autoDictionaryGetter (id self, SEL _cmd){
    //获取当前self的字典
    WKAutoDictionary *typedSelf = (WKAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}
@end
