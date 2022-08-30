//
//  CustomeControl.m
//  testSingature
//
//  Created by Rillakkuma on 2022/6/17.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import "DHCustomeControl.h"

@implementation DHCustomeControl
//centerInset 图片与文字上下间距
//updownset 图片文字整体距上距下高
- (instancetype)initWithFrame:(CGRect)frame centerInset:(CGFloat)centerInset updownInset:(CGFloat)updownInset imageName:(NSString *)imageName labelString:(NSString *)labelString labelFont:(CGFloat)font {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imageEquelheight = frame.size.height - updownInset * 2 - font - centerInset;
        CGFloat imageLeft = (frame.size.width - imageEquelheight)/2;
        _contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageLeft, updownInset, imageEquelheight, imageEquelheight)];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _contentImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_contentImageView];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_contentImageView.frame)  + centerInset, frame.size.width - 10,font)];
        _contentLabel.font = [UIFont systemFontOfSize:font];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.text = labelString;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
    }
    return self;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}
/*
 事件通知UIControl类提供了一个标准机制，来进行事件登记和接收。这令你可以指定你的控件在发生特定事件时，通知代理类的一个方法。如果要注册一个事件，可

 [ myControl addTarget: myDelegate

 action:@selector(myActionmethod:)

 forControlEvents:UIControlEventValueChanged ];

 事件可以用逻辑OR合并在一起，因此可以再一次单独的addTarget调用中指定多个事件。下列事件为基类UIControl所支持，除非另有说明，也适用于所有控件。UIControlEventTouchDown单点触摸按下事件：用户点触屏幕，或者又有新手指落下的时候。UIControlEventTouchDownRepeat

 多点触摸按下事件，点触计数大于1：用户按下第二、三、或第四根手指的时候。

  UIControlEventTouchDragInside当一次触摸在控件窗口内拖动时。

  UIControlEventTouchDragOutside当一次触摸在控件窗口之外拖动时。

  UIControlEventTouchDragEnter当一次触摸从控件窗口之外拖动到内部时。

  UIControlEventTouchDragExit当一次触摸从控件窗口内部拖动到外部时。

  UIControlEventTouchUpInside所有在控件之内触摸抬起事件。

  UIControlEventTouchUpOutside所有在控件之外触摸抬起事件(点触必须开始与控件内部才会发送通知)。UIControlEventTouchCancel

  所有触摸取消事件，即一次触摸因为放上了太多手指而被取消，或者被上锁或者电话呼叫打断。

  UIControlEventTouchChanged当控件的值发生改变时，发送通知。用于滑块、分段控件、以及其他取值的控件。你可以配置滑块控件何时发送通知，在滑块被放下时发送，或者在被拖动时发送。

  UIControlEventEditingDidBegin当文本控件中开始编辑时发送通知。UIControlEventEditingChanged当文本控件中的文本被改变时发送通知。UIControlEventEditingDidEnd当文本控件中编辑结束时发送通知。UIControlEventEditingDidOnExit当文本控件内通过按下回车键（或等价行为）结束编辑时，发送通知。UIControlEventAlltouchEvents通知所有触摸事件。UIControlEventAllEditingEvents通知所有关于文本编辑的事件。UIControlEventAllEvents通知所有事件。除了默认事件以外，自定义控件类还可以用0x0F000000到0x0FFFFFFF之间的值，来定义他们自己的时间。要删除一个或多个事件的相应动作，可以使用UIControl类的removeTarget方法。使用nil值就可以将给定事件目标的所有动作删除：

  [ myControl removeTarget:myDelegate action:nil forControlEvents:UIControlEventAllEvents];

  要取得关于一个控件所有指定动作的列表，可以使用allTargets方法。这个方法返回一个NSSet，其中包含事件的完整列表：

  NSSet* myActions = [myConreol allTargets ];

  另外，你还可以用actionsForTarget方法，来获取针对某一特定事件目标的全部动作列表：

  NSArray* myActions = [ myControl actionForTarget:UIControlEventValueChanged ];

  如果设计了一个自定义控件类，可以使用sendActionsForControlEvent方法，为基本的UIControl事件或自己的自定义事件发送通知。例如，如果你的控件值正在发生变化，就可以发送相应通知，通过控件的代码可以指定时间目标，这个通知将被传播到这些指定的目标。例：

  [ self sendActionsForControlEvents:UIControlEventValueChanged ];

  当委托类得到事件通知时，他将收到一个指向事件发送者的指针。下面的例子用于处理分段控件的事件，你的动作方法（action method）应遵循类似的处理方式：
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
