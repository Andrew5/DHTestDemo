//
//  DHButton.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import "DHButton.h"

@implementation DHButton

// 目标动作回调
- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}
//当button点击结束时，如果结束点在button区域中执行action方法
//通过target来执行action方法，触摸完成的事件中让target执行action方法，执行之前要判断一下触摸的释放点是否在按钮的区域内
// -(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//     //获取触摸对象
//     UITouch *touche = [touches anyObject];
//     //获取touche的位置
//     CGPoint point = [touche locationInView:self];
//
//     //判断点是否在button中
//     if (CGRectContainsPoint(self.bounds, point))
//     {
//         //执行action
//         [self.target performSelector:self.action withObject:self];
//     }
//
// }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 判断myButtonShouldTap是否在degate中实现啦:委托回调
    if ([self.delegate respondsToSelector:@selector(myButtonShouldTap:)]) {
        // 如果实现了，就获取button的状态
        myButtonState = [self.delegate myButtonShouldTap:self];
    }
    // 根据按钮的状态来做处理
    if (myButtonState) {
        // 如果myButtonWillTap被实现啦，此时我们就实现myButtonWillTapf方法
        if ([self.delegate respondsToSelector:@selector(myButtonWillTap:)]) {
            [self.delegate myButtonWillTap:self];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 点击结束要调用myButtonDidTap  委托回调
    if ([self.delegate respondsToSelector:@selector(myButtonDidTap:)]) {
        [self.delegate myButtonDidTap:self];
    }
}

// 实现block回调的方法
 - (void)setButtonWillBlock:(ButtonWillDidBlock)block {
     
     self.willBlock = block;
     if (self.willBlock) {
         self.willBlock(self);
     }
 }

 - (void)setButtonDidBlock:(ButtonWillDidBlock)block {
     
     self.didBlock = block;
     if (self.didBlock) {
         self.didBlock(self);
     }
 }

 - (void) setButtonShouldBlock:(ButtonShouldBlock)block {
     
     self.shouldBlock = block;
     myButtonState = self.shouldBlock(self);
 }
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
