//
//  DHTestMessage.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/22.
//

#import "DHTestMessage.h"
#import <UIKit/UIKit.h>

NSString * const ABC              = @"extern_iPhone";

//--- const ---//
/** 局部常量 只能内部调用 **/
static const NSString *personA1 = @"a1";//用static修饰后，不能提供外界访问
static NSString *const personA2 = @"a2";//字符串常量

/** 全局常量 外部可访问 **/
NSString *const personB = @"bb";        //表示无论内容，指向都不能改了
NSString const *personC = @"cc";        //指针指向的内容不可修改
const NSString *personD = @"dd";        //相当于指针本身不可修改

//----extern-----//
/** 全局变量 外部可访问 **/
//注意：在定义全局变量的时候不能初始化，否则会报错！
extern NSString *personE;               //外部调用,动态传参


typedef struct{
    int id;
    float height;
    unsigned char flag;
}MyTestStruct;


@interface Animal : NSObject
-(void)action;
@end
@implementation Animal
- (void)action{
    NSLog(@"animal action");
}
@end
@interface Fish : Animal
-(void)action;
-(void)bubble;
@end
@implementation Fish
- (void)action{
    NSLog(@"Fish can swim");
}
-(void)bubble{
    NSLog(@"Fish can bubble");
}
@end
@interface Bird : Animal
-(void)action;
@end
@implementation Bird
- (void)action{
    NSLog(@"Bird can fly");
}
@end

@interface Dog : Animal
-(void)action;
@end
@implementation Dog
- (void)action{
    NSLog(@"Dog can call");
}
@end
@interface Rabbit : Animal
-(void)action;
@end
@implementation Rabbit
- (void)action{
    NSLog(@"Rabbit can jump");
}
@end

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
static inline int add(int a, int b){
    return a + b;
}
static  int arr[] = {
    
};
void doAction(Animal *obj){
    [obj action];
}
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
    add(2, 3);
    ///TODO: NSValue
    MyTestStruct testStruct;
    testStruct.id = 1001;
    testStruct.height = 23.5f;
    testStruct.flag = 1;
    
    NSValue *nsValue= [NSValue valueWithBytes:&testStruct objCType:@encode(MyTestStruct)];
    
    MyTestStruct testStruct2;
    [nsValue getValue:&testStruct2];
    
    NSLog(@"id %i",testStruct2.id);
    NSLog(@"height %f",testStruct2.height);
    NSLog(@"flag %i",testStruct2.flag);
    
    CGPoint point = CGPointMake(100, 100);
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    
    NSLog(@"x = %f,y = %f",[pointValue CGPointValue].x,[pointValue CGPointValue].y);
    
    int n = 110;
    int *pn = &n;
    NSValue *pointer = [NSValue valueWithPointer:pn];
    int *pn2 = [pointer pointerValue];
    NSLog(@"%i",*pn2);
 
    
    ///TODO:多态 动物园
    Rabbit *rabbit = [[Rabbit alloc]init];
    Dog *dog = [[Dog alloc]init];
    Fish *fish = [[Fish alloc]init];
    Bird *bird = [[Bird alloc]init];

    Animal *zoom[4] = {rabbit,dog,fish,bird};
    for (int i = 0; i<4; i++) {
        doAction(zoom[i]);
    }
    ///多态局限性
    Animal *obj = [[Fish alloc]init];
    [obj action];
    [(Fish *)obj bubble];
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
