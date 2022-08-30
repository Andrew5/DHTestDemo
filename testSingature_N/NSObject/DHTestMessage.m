//
//  DHTestMessage.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/22.
//

#import "DHTestMessage.h"
#import <UIKit/UIKit.h>

@implementation testDog
- (void)saygoodbay{
    NSLog(@"adf");
}
@end

#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
static DHTestMessage *_testMessage;
@interface DHTestMessage ()
@property (nonatomic, strong) testDog *dog;

@end

@implementation DHTestMessage
- (testDog *)dog{
    if (!_dog) {
        
        _dog = [[testDog alloc]init];
    }
    return _dog;
}
+ (NSObject *)sharedDog{
    return _testMessage.dog;
    //返回 <testDog: 0x7fd8dbf05b40>
}
+ (testDog *)sharedSubDog{
    return _testMessage.dog;
}

+ (void)testAddFunction{
    [self  sharedDog];//返回 <testDog: 0x7fd8dbf05b40>
    [_testMessage.dog saygoodbay];
    
    //上面两个方法跟这个有甚区别
    [[self  sharedSubDog] saygoodbay];
}
- (void)saySomething{
    NSLog(@"-1OC--");
}
+ (DHTestMessage *)sharedInstance{
    static dispatch_once_t once;
    static DHTestMessage *instance;
    dispatch_once(&once, ^{
        instance = [[DHTestMessage alloc] init];
    });
    return instance;
}

- (void)setFragment:(NSString *)fragment {
    _fragment = fragment;
    if (_fragment.length <= 0) {
            self.titleActualH = 0;
            self.titleMaxH = 0;
        } else {
            NSUInteger numCount = 2; //这是cell收起状态下期望展示的最大行数
            NSString *str = @"这是一行用来计算高度的文本"; //这行文本也可以为一个字，但不能太长
            CGFloat W = 284;//kScreenWidth-30; //这里是文本展示的宽度
            self.titleActualH = [_fragment boundingRectWithSize:CGSizeMake(W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            self.titleMaxH = [str boundingRectWithSize:CGSizeMake(W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height*numCount;
        }
}

//静态方法调用实例方法
- (void)testSubtractFunction{

}
@end
