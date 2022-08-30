//
//  DHButton.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 二 添加代理
@class DHButton;
// 定义MyButton要实现的协议, 用于委托回调
@protocol DHButtonDelegete <NSObject>
// 可选择的实现
@optional
// 当button将要点击时调用
- (void)myButtonWillTap:(DHButton *)sender;
// 当button点击后做的事情
- (void)myButtonDidTap:(DHButton *)sender;
// 判断button是否可以被点击
- (BOOL)myButtonShouldTap:(DHButton *)sender;
@end

@interface DHButton : UIView {
    BOOL myButtonState;
}
// 一 添加目标动作回调
@property (nonatomic,weak) id target;
@property (nonatomic, assign) SEL action;
- (void)addTarget:target action:(SEL)action;
// 二 添加代理
@property (nonatomic, weak) id <DHButtonDelegete> delegate;
// 三 Block回调
typedef void (^ButtonWillDidBlock) (DHButton *sender);
typedef BOOL (^ButtonShouldBlock) (DHButton *sender);
// 接受block的方法
- (void)setButtonWillBlock:(ButtonWillDidBlock)block;
- (void)setButtonDidBlock:(ButtonWillDidBlock)block;
- (void)setButtonShouldBlock:(ButtonShouldBlock)block;

// 接受block块
@property (nonatomic, strong) ButtonWillDidBlock willBlock;
@property (nonatomic, strong) ButtonWillDidBlock didBlock;
@property (nonatomic, strong) ButtonShouldBlock shouldBlock;
@end

NS_ASSUME_NONNULL_END
