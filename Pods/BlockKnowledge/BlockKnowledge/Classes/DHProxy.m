//
//  DHProxy.m
//  DHBasicKnowledge
//
//  Created by jabraknight on 2022/4/28.
//

#import "DHProxy.h"

@implementation DHProxy
- (id)transformObjc:(NSObject *)objc{
    _objc = objc;
    return self;
}

+ (instancetype)proxyWithObjc:(id)objc{
    return  [[self alloc] transformObjc:objc];
}

// 查询该方法的方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSMethodSignature *signature;
    if (self.objc) {
        signature = [self.objc methodSignatureForSelector:sel];
    } else{
        signature = [super methodSignatureForSelector:sel];
    }
    return signature;
}

// 有了方法签名之后就会调用方法实现
- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.objc respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.objc];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.objc respondsToSelector:aSelector];
}
@end
