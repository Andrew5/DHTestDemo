//
//  AspectProxy.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/10.
//

#import "AspectProxy.h"
/*
 为每个类定义一个转发对象，该转发对象继承自 NSObject 并实现 NSObject 的 forwardInvocation: 方法。在该方法中，我们可以插入埋点代码，例如记录方法调用的时间、参数等信息
 
 使用 runtime 动态地为每个类创建一个转发对象，并将该转发对象设置为该类的转发对象。
 
 通过在原有类的方法中调用 self 来触发埋点，例如在原有方法的开头插入 [self doSomething]，其中 doSomething 是一个不存在的方法。这样，在调用该方法时，会先触发埋点代码，然后再调用原有方法
 
 使用 objc_allocateClassPair() 函数创建一个新类。
 使用 class_addMethod() 函数为这个类定义一个方法，这个方法就是切点。
 在切点方法中实现埋点逻辑。
 为新类定义转发对象，这样当公共页面调用某个方法时，会先调用转发对象的 forwardingTargetForSelector: 方法。
 在转发对象的 forwardingTargetForSelector: 方法中，返回新类的实例，这样在公共页面调用某个方法时，就会执行新类的实例的这个方法，也就是切点方法，从而实现埋点功能。
 
 */
@implementation AspectProxy
//- (void)forwardInvocation:(NSInvocation *)invocation
//{
//    // 在这里插入埋点代码，例如记录方法调用的时间、参数等信息。
//    // ...
//
//    // 调用原有方法
//    [invocation invoke];
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
  return [self.receiver methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
  // 在这里插入前置埋点代码
  [invocation invokeWithTarget:self.receiver];
  // 在这里插入后置埋点代码
}

@end

// 动态创建类并为类定义方法
void aspect_hookClassMethod(Class cls, SEL selector, BOOL isClassMethod) {
    if (!cls) return;
    
    Method method = class_getInstanceMethod(cls, selector);
    if (!method) return;
    
    // 创建类
    NSString *className = NSStringFromClass(cls);
    Class aspectClass = NSClassFromString(className);
    if (!aspectClass) {
        aspectClass = objc_allocateClassPair(cls, className.UTF8String, 0);
        objc_registerClassPair(aspectClass);
    }
    
    // 为类定义方法
    IMP originalIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(aspectClass, selector, originalIMP, types);
    
    // 创建转发对象
    AspectProxy *proxy = [[AspectProxy alloc] init];
    proxy.receiver = isClassMethod ? object_getClass((id)cls) : cls;
    
    // 为类定义转发对象
    object_setClass(isClassMethod ? object_getClass((id)cls) : cls, aspectClass);
    class_addProtocol(aspectClass, @protocol(NSObject));
    Method oldM = class_getInstanceMethod(aspectClass, @selector(forwardingTargetForSelector:));
//    class_addMethod(objc_getClass("MyClass"), @selector(commonPageMethod), (IMP)commonPageMethod, "v@:");
    class_addMethod(aspectClass, @selector(forwardingTargetForSelector:), method_getTypeEncoding(oldM), "@@::");
    
    // 实现 forwardingTargetForSelector: 方法
    SEL forwardingSelector = @selector(forwardingTargetForSelector:);
    Method forwardingMethod = class_getInstanceMethod(aspectClass, forwardingSelector);
}

