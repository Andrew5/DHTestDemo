//
//  LCSafeObj.m
//  testSingature
//
//  Created by jabraknight on 2022/4/21.
//  Copyright © 2022 zk. All rights reserved.
//

#import "LCSafeObj.h"
@interface LCSafeObj ()
@property (nonatomic, weak) NSTimer *timer;
//对外部target的引用采取weak弱引用，以保证外部对象的正常释放
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selecter;
@property (nonatomic, copy) void (^timerEventBlock)(void);

@end
@implementation LCSafeObj
- (instancetype)initWithTarget:(id)target selecter:(SEL)selecter  timerEventBlock:(void (^)(void))timerEventBlock{
    if (self = [super init]) {
        self.target = target;
        self.selecter = selecter;
        self.timerEventBlock = timerEventBlock;
    }
    return self;
}

- (void)setTimer:(NSTimer *)timer{
    _timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

+ (NSTimer *)addTimerInterval:(NSTimeInterval)interval target:(id)target selecter:(SEL)selecter isrepeat:(BOOL)repeat{
    //此时LCSafeObj单独引用外部对象
    LCSafeObj *safeObj = [[LCSafeObj alloc] initWithTarget:target selecter:selecter timerEventBlock:nil];
    //注意这里的Target传入的是LCSafeObj类型的，并不是外部对象，目的是让定时器timer引用新引入的对象C，
    safeObj.timer =
    [NSTimer scheduledTimerWithTimeInterval:interval target:safeObj selector:@selector(targetAction) userInfo:nil repeats:repeat];
    //返回给传入的对象，让其单引用定时器timer，且控制定时器的invalid的时间，至此完成单链的引用
    return safeObj.timer;
}

//定时器事件方法中判断target引用是否依旧存在，不存在则使用invalidDate 去除定时器timer对于引入的对象C的引用
- (void)targetAction{
    if (!self.target) {
        [self.timer invalidate];
    }
    if (self.target && [self.target respondsToSelector:self.selecter]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selecter];
#pragma clang diagnostic pop
    }
    if (self.timerEventBlock) {self.timerEventBlock();}
}

/// 使用消息转发来将SafeObj中没有的方法调用转移到传入的对象中
/// @param aSelector 方法转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == self.selecter) {
        return self.target;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
