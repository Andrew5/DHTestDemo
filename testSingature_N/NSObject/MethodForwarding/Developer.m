//
//  Developer.m
//  testSingature
//
//  Created by jabraknight on 2021/11/30.
//  Copyright © 2021 zk. All rights reserved.
//

#import "Developer.h"
#import <objc/runtime.h>
#import "WKAutoDictionary.h"

@implementation Developer
- (void)doDeveloper {
    NSLog(@"Developer doWork!");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    /*
     如果当前对象调用了一个不存在的方法
     Runtime会调用resolveInstanceMethod:来进行动态方法解析
     我们需要用class_addMethod函数完成向特定类添加特定方法实现的操作
     返回NO，则进入下一步forwardingTargetForSelector:
     */
    /*
    class_addMethod(self,
                    sel,
                    class_getMethodImplementation(self, sel_registerName("doDeveloper")),
                    "v@:");
    return [super resolveInstanceMethod:sel];
     */
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    /*
     在消息转发机制执行前，Runtime 系统会再给我们一次重定向的机会
     通过重载forwardingTargetForSelector:方法来替换消息的接受者为其他对象
     返回nil则进步下一步forwardInvocation:
     */
    /*
    return [[Finance alloc] init];
     */
    return nil;
}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    /*
     获取方法签名进入下一步，进行消息转发
     */
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    /*
     消息转发
     */
    
    return [anInvocation invokeWithTarget:[[WKAutoDictionary alloc] init]];
}
@end
