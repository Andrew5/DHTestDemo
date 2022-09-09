//
//  LCSafeObj.h
//  testSingature
//
//  Created by jabraknight on 2022/4/21.
//  Copyright © 2022 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//如果是iOS10以上，我们可以直接使用timer的 scheduledTimerWithTimeInterval:repeats:block:方法进行设置
//可以引入新的对象C，将引用链由A->B,B->A 改成 A->C, C->B, B->A
//引入新对象C之后，三者引用关系就如上图，这样就不存在两个对象之间相互引用了，在销毁对象的时候，只需要消除其中一条引用，则可以全部消除引用关系。比如ObjectA在销毁前，可以向Timer发送invalidate消息，消除对于ObjectC的引用，这样就消除了一个引用关系，过程如下：
//
//调用timer的 invidate方法结束定时器对对象C的引用，让引入的新对象C先dealloc
//引入的新对象C的释放，结束了对于对象A的引用，当前对象A也紧接着dealloc了
//当前对象A的释放，结束了对于定时器B的引用，定时器对象B也紧接着dealloc了

@interface LCSafeObj : NSObject
- (instancetype)initWithTarget:(id)target selecter:(SEL)selecter  timerEventBlock:(void (^)(void))timerEventBlock;

@end

NS_ASSUME_NONNULL_END
