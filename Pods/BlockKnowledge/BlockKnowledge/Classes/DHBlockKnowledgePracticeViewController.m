//
//  DHBlockKnowledgePracticeViewController.m
//  DHBasicKnowledge
//
//  Created by jabraknight on 2022/4/27.
//
#import "DHProxy.h"
#import "CSPTimerMananger.h"

typedef void (^CancelableBlock)(void);
typedef void (^Block)(void);
@interface BlockObject : NSObject {
    BOOL _isCanceled;
    Block _block;
}
/** 名称 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic,assign) float tmp;

@property(nonatomic,strong) NSString *resultString;

@property(nonatomic,assign) CGFloat resultCalculator;

typedef BlockObject *_Nullable(^RJCalculator)(CGFloat num);
@property (nonatomic, strong, readonly) RJCalculator plus;
@property (nonatomic, strong, readonly) RJCalculator subtract;
@property (nonatomic, strong, readonly) RJCalculator multiply;
@property (nonatomic, strong, readonly) RJCalculator divide;

@property (nonatomic, strong, readonly) BlockObject *(^date)(NSString *str);
@property (nonatomic, strong, readonly) BlockObject *(^who)(NSString *str);
@property (nonatomic, strong, readonly) BlockObject *(^note)(NSString *str);

@property (nonatomic, copy) void (^selfBlock)(void);

- (void)theResponse;
//计算
+ (CGFloat)makeCalculator:(void(^)(BlockObject *rj_tool))block;
//拼接字符串
+ (NSString *)makeAppendingString:(void(^)(BlockObject *rj_tool))block;

+ (void)numberInforDic:(void(^)(NSDictionary * inforDic))inforBlock;

//instancetype用来在编译期确定实例的类型,而使用id的话,编译器不检查类型, 运行时检查类型
//instancetype和id一样,不做具体类型检查
//id可以作为方法的参数,但instancetype不可以
//instancetype只适用于初始化方法和便利构造器的返回值类型
- (instancetype)initWithProperty:(NSDictionary*)property;

- (id)initWithBlock:(Block)block;
- (void)start;
- (void)cancel;

@end

@implementation BlockObject

- (void)setName:(NSString *)name {
    NSLog(@"输出--%@",name);
}

- (void)theResponse {
    NSLog(@"theResponse");
}

/*************************** 拼接字符串 *******************************/
+ (NSString *)makeAppendingString:(void (^)(BlockObject *))block {
    if (block) {
        BlockObject *tool = [[BlockObject alloc] init];
        tool.resultString = @"date,who一起去看电影,备注:note";
        block(tool);
        return tool.resultString;
    }
    return @"为什么你什么都不说?";
}
- (BlockObject *(^)(NSString *))date {
    return [^(NSString *str){
        self.resultString = [self.resultString stringByReplacingOccurrencesOfString:@"date" withString:str];
        return self;
    }copy];
}
- (BlockObject *(^)(NSString *))who {
    return [^(NSString *str){
        self.resultString = [self.resultString stringByReplacingOccurrencesOfString:@"who" withString:str];
        return self;
    }copy];
}
- (BlockObject *(^)(NSString *))note {
    return [^(NSString *str){
        self.resultString = [self.resultString stringByReplacingOccurrencesOfString:@"note" withString:str];
        return self;
    }copy];
}
/*************************** 拼接字符串 *******************************/

/*************************** 计算(加减乘除) *******************************/
+ (CGFloat)makeCalculator:(void (^)(BlockObject *))block {
    if (block) {
        BlockObject *tool = [[BlockObject alloc] init];
        block(tool);
        return tool.resultCalculator;
    }
    return 0;
}

- (void)useBlock {
    NSLog(@"计算结果1-->%f",[BlockObject makeCalculator:^(BlockObject *rj_tool) {
        rj_tool.plus(10).subtract(2).multiply(5).divide(8);
    }]);
    
    NSLog(@"计算结果2-->%f",[BlockObject makeCalculator:^(BlockObject *rj_tool) {
        rj_tool.plus(10);
        rj_tool.subtract(2);
        rj_tool.multiply(5);
        rj_tool.divide(5);
    }]);
    
    NSLog(@"拼接的结果:-->%@",[BlockObject makeAppendingString:^(BlockObject *rj_tool) {
        rj_tool.date(@"今天").who(@"我和她").note(@"嘿嘿嘿");
    }]);
    
    NSLog(@"输出--%d",self.eatFood(200));
    
    self.add(200);

}

- (RJCalculator)plus {
    return [^(CGFloat num){
        self.resultCalculator += num;
        return self;
    }copy];
}
- (RJCalculator)subtract {
    return [^(CGFloat num){
        self.resultCalculator -= num;
        return self;
    }copy];
}
- (RJCalculator)multiply {
    return [^(CGFloat num){
        self.resultCalculator *= num;
        return self;
    }copy];
}
- (RJCalculator)divide {
    return [^(CGFloat num){
        self.resultCalculator /= num;
        return self;
    }copy];
}
/*
 - (TABBaseComponentBlock _Nullable)animation {
     __weak typeof(self) weakSelf = self;
     return ^TABBaseComponent *(NSInteger index) {
         NSString *key = tab_NSStringFromIndex(index);
         if (!weakSelf.componentDict[key]) {
             NSAssert(NO, @"Array bound, please check it carefully.");
             TABComponentLayer *layer = TABComponentLayer.new;
             layer.loadStyle = TABViewLoadAnimationRemove;
             return [TABBaseComponent componentWithLayer:layer manager:weakSelf];
         }
         return weakSelf.componentDict[key];
     };
 }
 */
/*************************** 计算(加减乘除) *******************************/
- (void (^)(float))add {
    __weak typeof(self) wself = self;
    void (^result)(float) = ^(float value){
        wself.tmp += value;
    };
    return result;
}
- (int (^)(int))eatFood{
    return ^(int food){
        return 1+food;
        NSLog(@"狗狗吃了%d斤狗粮",food);
    };
}

NSString *lhString=@"hello-extern";
- (instancetype)initWithProperty:(NSDictionary *)property {
    if (self =[super init]) {
        NSLog(@"----%@",property);
    }
    return self;
}
+ (void)numberInforDic:(void (^)(NSDictionary * _Nonnull))inforBlock {
    NSLog(@"----%@",inforBlock);
}

/**
 将要执行的 block 直接放到执行队列中，但是让其在执行前检查另一个 isCanceled 的变量，然后把这个变量的修改实现在另一个 block 方法中
 */
+ (CancelableBlock)dispatch_async_with_cancelable:(Block)block {

    __block BOOL isCanceled = NO;
    CancelableBlock cb = ^() {
        isCanceled = YES;
    };

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!isCanceled) {
            block();
        }
    });

    return cb;
}
//创建一个类，将要执行的 block 封装起来，然后类的内部有一个 _isCanceled 变量，在执行的时候，检查这个变量，如果 _isCanceled 被设置成 YES 了，则退出执行
- (id)initWithBlock:(Block)block {
    self = [super init];
    if (self != nil) {
        _isCanceled = NO;
        _block = block;
    }
    return self;
}

- (void)start {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0),
       ^{
        if (weakSelf) {
           typeof(self) strongSelf = weakSelf;
           if (!strongSelf->_isCanceled) {
               (strongSelf->_block)();
           }
        }
    });
}

- (void)cancel {
    _isCanceled = YES;
}

@end

@interface ResponseObject : NSObject
- (void)theResponseSubFunc ;
@end

@implementation ResponseObject

- (void)theResponseSubFunc {
    NSLog(@"theResponseSubFunc");
}

@end

#import "DHBlockKnowledgePracticeViewController.h"
#import <objc/message.h>
#include <pthread.h>
#import <mach/mach_time.h>

//block本质上也是一个OC对象，它内部也有个isa指针
//block是封装了函数调用以及函数调用环境的OC对象
// 属性声明的block都是全局的__NSGlobalBlock__
//用typedef定义 一个block:
typedef int (^MyBlock)(int , int);
typedef void (^KnowledgePracticeBlock)(NSString * _Nonnull showText);
typedef void(^ClassBlockObject)(DHBlockKnowledgePracticeViewController *);
typedef void (^CustomEvent)(NSString* str);//本类测试

@interface DHBlockKnowledgePracticeViewController () {
    int _xxx;
    /*
     内存管理语义
     
     1.关键词
     strong：表示指向并拥有该对象。其修饰的对象引用计数会 +1 ，该对象只要引用计数不为 0 就不会销毁，强行置空可以销毁它。一般用于修饰对象类型、字符串和集合类的可变版本。
     copy：与strong类似，设置方法会拷贝一份副本。一般用于修饰字符串和集合类的不可变版， block用copy修饰。
     weak：表示指向但不拥有该对象。其修饰的对象引用计数不会增加，属性所指的对象遭到摧毁时属性值会清空。ARC环境下一般用于修饰可能会引起循环引用的对象，delegate用weak修饰，xib控件也用weak修饰。
     assign：主要用于修饰基本数据类型，如NSIteger、CGFloat等，这些数值主要存在于栈中。
     unsafe_unretained：与weak类似，但是销毁时不自动清空，容易形成野指针。
     
     2.比较 copy 与 strong
     copy与strong：相同之处是用于修饰表示拥有关系的对象。不同之处是strong复制是多个指针指向同一个地址，而copy的复制是每次会在内存中复制一份对象，指针指向不同的地址。NSString、NSArray、NSDictionary等不可变对象用copy修饰，因为有可能传入一个可变的版本，此时能保证属性值不会受外界影响。
     注意：若用strong修饰NSArray，当数组接收一个可变数组，可变数组若发生变化，被修饰的属性数组也会发生变化，也就是说属性值容易被篡改；若用copy修饰NSMutableArray，当试图修改属性数组里的值时，程序会崩溃，因为数组被复制成了一个不可变的版本。
     
     3.比较 assign、weak、unsafe_unretain
     
     相同点：都不是强引用。
     不同点：weak引用的 OC 对象被销毁时, 指针会被自动清空，不再指向销毁的对象，不会产生野指针错误；unsafe_unretain引用的 OC 对象被销毁时, 指针并不会被自动清空, 依然指向销毁的对象，很容易产生野指针错误:EXC_BAD_ACCESS；assign修饰基本数据类型，内存在栈上由系统自动回收。
     
     Property的默认设置
     
     基本数据类型：atomic, readwrite, assign
     对象类型：atomic, readwrite, strong
     注意：考虑到代码可读性以及日常代码修改频率，规范的编码风格中关键词的顺序是：原子性、读写权限、内存管理语义、getter/getter。
     
     延伸
     
     我们已经知道 @property 会使编译器自动编写访问这些属性所需的方法，此过程在编译期完成，称为 自动合成 (autosynthesis)。与此相关的还有两个关键词：@dynamic 和 @synthesize。
     
     @dynamic：告诉编译器不要自动创建实现属性所用的实例变量，也不要为其创建存取方法。即使编译器发现没有定义存取方法也不会报错，运行期会导致崩溃。
     @synthesize：在类的实现文件里可以通过 @synthesize 指定实例变量的名称。
     注意：在Xcode4.4之前，@property 配合 @synthesize使用，@property 负责声明属性，@synthesize 负责让编译器生成 带下划线的实例变量并且自动生成setter、getter方法。Xcode4.4 之后 @property 得到增强，直接一并替代了 @synthesize 的工作。
     
     函数参数是以数据结构:栈的形式存取,从右至左入栈。
     首先是参数的内存存放格式：参数存放在内存的堆栈段中，在执行函数的时候，从最后一个开始入栈。因此栈底高地址，栈顶低地址。
     举个例子如下：void func(int x, float y, char z);
     那么，调用函数的时候，实参 char z 先进栈，然后是 float y，最后是 int x，因此在内存中变量的存放次序是 x->y->z，因此，从理论上说，我们只要探测到任意一个变量的地址，并且知道其他变量的类型，通过指针移位运算，则总可以顺藤摸瓜找到其他的输入变量。
     */
}
@property (nonatomic, assign) int numC;
@property (nonatomic,   copy) MyBlock myBlockOne;
@property (nonatomic,   copy) ClassBlockObject myBlock;

@property (nonatomic,   copy) KnowledgePracticeBlock _Nullable returnTextBlock;


- (void)returnText:(KnowledgePracticeBlock _Nonnull )block;

+ (void)getMyBestMethod:(void (^_Nullable)(NSDictionary * _Nonnull))then;
- (void)getMyBestMethod:(void (^_Nonnull)(NSString * _Nonnull))then;
- (void)showIndex: (NSInteger) index;
@end

@implementation DHBlockKnowledgePracticeViewController
/*
 1. block作用：

 Block用来封装一段代码,可以在任何时候执行；

 Block可以作为函数参数或者函数的返回值,而其本身又可以带输入参数或返回值。
 苹果官方建议尽量多用block。在多线程、异步任务 、集合遍历、集合排序、动画转场用的很多
 在新的iOS API中block被大量用来取代传统的delegate和callback，而新的API会大量使用block主要是基于以下两个原因：

 A. 可以直接在block代码块中写等会要接着执行的代码，直接把block变成函数的参数传入函数中，这是新API最常使用block的地方。

 B. 可以存取局部变量，在传统的callback操作时，若想要存取局部变量得将变量封装成结构体才能使用，而block则是可以很方便地直接存取局部变量。
 2. Block的定义:

 定义时，把block当成数据类型

 特点：
 1. 类型比函数定义多了一个 ^
 2. 设置数值，有一个 ^，内容是 {} 括起的一段代码
 (1)基本定义方式

 
 *1.最简单的定义方式:
 *格式：void (^myBlock)() = ^ { // 代码实现; }
 
 void (^myBlock)() = ^ {
     NSLog(@"hello");
 };
  
 // 执行时，把block当成函数
 myBlock();
 
 无参无返回值
 void(^block1)(void) = ^void(void) {
     NSLog(@"无参无返回值");
 };
 // 调用
 block1();
 
 2.定义带参数的block:
 格式：void (^block名称)(参数列表) = ^ (参数列表) { // 代码实现; }
 
 void (^sumBlock)(int, int) = ^ (int x, int y) {
     NSLog(@"%d", x + y);
 };
 sumBlock(10, 20);
  
 // 有参无返回值
 void (^block2)(NSString *, NSMutableArray *) = ^void(NSString *string, NSMutableArray *array) {
     [array addObject:string];
     NSLog(@"%@", array);
 };
 // 参数传入
 block2(@"abc", [NSMutableArray array]);
 
 3.定义带返回值的block
 格式：返回类型 (^block名称)(参数列表) = ^ 返回类型 (参数列表) { // 代码实现; }
 
 int (^sumBlock2)(int, int) = ^ int (int a, int b) {
     return a + b;
 };
  
 NSLog(@"%d", sumBlock2(4, 8));
 
 // 3.无参有返回值
 NSInteger (^block3)(void) = ^(void) {
     return 100l;
 };
 NSLog(@"%ld", block3());
 
 // 4.有参有返回值
 NSMutableDictionary *(^block4)(NSString *, NSArray *) = ^(NSString *string, NSArray *array) {
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     [dic setObject:array forKey:string];
     return dic;
 };
 NSLog(@"%@", block4(@"alphabet", @[@"a", @"b"]));
 
 (2) block 指针

 Block Pointer是这样定义的：

 回传值 (^名字) (参数列);
 //声明一个名字为square的Block Pointer，其所指向的Block有一个int输入和int输出
 int (^square)(int);
  
 //block 指针square的内容
 square = ^(int a){ return a*a ; };
  
 //调用方法，感觉是是不是很像function的用法？
 int result = square(5);
 NSLog(@"%d", result);
 
 (3) 用typedef先声明类型,再定义变量进行赋值

 typedef int (^MySum)(int,int);
 MySum sum = ^(int a,int b)
  {
       return a + b;
 };

 (4) block 访问外部变量

 但是block使用有个特点，Block可以访问局部变量，但是不能修改：

 int sum = 10;
  int (^MyBlock)(int) = ^(int num)
 {
      sum++;//编译报错
      return num * sum;
 };

 如果要修改就要加关键字 __block （下面详细说明）:

 __block int sum =10;
 (5) block 与函数指针

 下面比较下函数指针与block异同：

 定义函数指针 int (*myFn)();
 调用函数指针 (*myFn)(10, 20);

 定义Block int (^MyBlocks)(int,int);
 调用Blocks MyBlocks(10, 20);

 3. block访问外部变量

 block 访问外部变量有几个特点必须知道：

 block内部可以访问外部变量；
 默认情况下block内部不能修改外面的局部变量；
 给局部变量加上关键字_block,这个局部变量就可以在block内部修改；
 block中可以访问外部变量。但是不能修改它，否则编译错误。但是可以改变全局变量、静态变量(static)、全局静态变量。
 上面的特点是有原因滴：

 A. 为何不让修改变量：这个是编译器决定的。理论上当然可以修改变量了，只不过block捕获的是外部变量的副本，名字一样。为了不给开发者迷惑，干脆不让赋值。道理有点像：函数参数，要用指针，不然传递的是副本（大家想起那个经典的两个数调换值的问题了吧）。

 B. 可以修改静态变量的值。静态变量属于类的，不是某一个变量。所以block内部不用调用cself指针。所以block可以调用。
 (1) __block存储类型

 通过__block存储类型修饰符， 变量在block中可被修改。__block存储跟register、auto和static存储类型相似（但是之间互斥），用于局部变量。__block变量存储在堆区，因此，这个block使用的外部变量，将会在栈结束被留下来。

 从优化角度考虑，block存储在栈上，如果block被拷贝（通过Block_copy或者copy）,变量被拷贝到堆。因此__block变量的地址就会改变。

 __block变量还有两个限制，他们不能是可变数组(NSMutableArray)，不能是结构体(structure)。

 __block 变量的内部实现要复杂许多，__block 变量其实是一个结构体对象，拷贝的是指向该结构体对象的指针
 (2) block访问外部变量

 上面已经说过，默认block 访问的外部变量是只读属性的，若要对外部变量进行读写，需要在定义外部变量时加一个 __block， 示例如下：

 //示例1：block访问外部变量
 void demoBlock1()
 {
     int x = 10;
     NSLog(@"定义前 %p", &x);// 局部变量在栈区
  
     // 在定义block的时候，如果引用了外部变量,默认是把外部变量当做是常量编码到block当中，并且把外部变量copy到堆中，外部变量值为定义block时变量的数值
     // 如果后续再修改x的值，默认不会影响block内部的数值变化！
     // 在默认情况下，不允许block内部修改外部变量的数值！因为会破坏代码的可读性，不易于维护！
     void(^myBlock)() = ^ {
  
         NSLog(@"%d", x);
         NSLog(@"in block %p", &x); // 堆中的地址
     };
     //输出是10,因为block copy了一份x到堆中
  
     NSLog(@"定义后 %p", &x);  // 栈区
     x = 20;
  
     myBlock();
 }
 
 //示例2：在block中修改外部变量
 void demoBlock2()
 {
     // 使用 __block，说明不在关心x数值的具体变化
     __block int x = 10;
     NSLog(@"定义前 %p", &x);                 // 栈区
  
     // ！定义block时，如果引用了外部使用__block的变量，在block定义之后, block外部的x和block内部的x指向了同一个值,内存地址相同
     void (^myBlock)() = ^ {
         x = 80;
         NSLog(@"in block %p", &x);          // 堆区
     };
     NSLog(@"定义后 %p", &x);                 // 堆区
  
     myBlock();
     NSLog(@"%d", x);
     //打印x的值为8，且地址在堆区中
 }

 下面的例子就有点难度了，让我们看下block对指针变量的访问

 //例子3：block对指针变量的访问
 void demoBlock3()
 {
     // ！指针记录的是地址
     NSMutableString *strM = [NSMutableString stringWithString:@"zhangsan"];
     //strM是指针，其在堆中存储的是zhangsan这个string在内存中的的地址值
     //&strM是指针strM在堆中的地址
     NSLog(@"定义前 %p %p", strM, &strM);
  
     void (^myBlock)() = ^ {
         首先调用block会对strM（指针）进行一份copy,这份copy会在堆中创建
         另一个指针，这个指针存储的值同strM，都是zhangsan的地址，
         即新copy的指针指向的内容没有变
         
  
         // 注意下面的操作是修改strM指针指向的内容
         [strM setString:@"lisi"];
         NSLog(@"inblock %p %p", strM, &strM);
         //输出：strM没有变，因为存储的都是zhangsan的地址,&strM为堆中新地址
  
         
         *这句代码是修改指针strM，因为strM copy过来后是只读的，所以同例子2编译会报错，需要在定义strM时加__block
         strM = [NSMutableString stringWithString:@"wangwu"];
         NSLog(@"inblock %p %p", strM, &strM);
         
     };
  
     //大家想想使用__block输出会是什么呢
     NSLog(@"定义后 %p %p", strM, &strM);
  
     myBlock();
     NSLog(@"%@", strM);
 }

 上面的例子搞定了，来让我们看下各种类型的变量与block之间的互动：

 //示例4：各种类型的变量和block之间的互动
   extern NSInteger CounterGlobal;
   static NSInteger CounterStatic;
  
   NSInteger localCounter = 42 ;
   __block char localCharacter;
   void (^aBlock)( void ) = ^( void )
   {
       ++ CounterGlobal ; //可以存取。
       ++ CounterStatic ; //可以存取。
  
       CounterGlobal = localCounter; //localCounter在block 建立时就不可变了。
       localCharacter = 'a' ; //设定外面定义的localCharacter 变数。
   };
  
   ++localCounter; //不会影响的block 中的值。
   localCharacter = 'b' ;
   aBlock(); //执行block 的内容。
  
   //执行完后，localCharachter 会变成'a'

 (3) block 引用成员变量

 OC对象，不同于基本类型，Block会引起对象的引用计数变化。若我们在block中引用到oc的对象，则对象的引用计数器会加1， 不过在对象前 加__block修饰，则参考计数不变。

 - 若直接存取实例变量（instance variable），self的参考计数将被加1。
 - 若透过变量存取实例变量的值，则变量的参考计数将被加1。
 - 在对象前加 __block 则参考计数不会自动加1。
 //例子1：定义一个变量间接给block调用，成员变量引用计数不变
 dispatch_async (queue, ^{
    // 因为直接存取实例变量instanceVariable ，所以self 的retain count 会加１
    doSomethingWithObject (instanceVariable);
 });
  
 //通过
 id localVaribale = instanceVariable;
 dispatch_async (queue, ^{
    //localVariable 是存取值，所以这时只有localVariable 的retain count 加１
    //self 的　return count 　并不会增加。
   doSomethingWithObject (localVaribale);
 });

 上面只是简单演示下block引用成员变量，下面我们研究下block引用成员变量时出现的一个经典问题：循环引用。

 在block内部使用成员变量，如下：

 @interface ViewController : UIViewController
 {
     NSString *_string;
 }
 @end

 在block创建中：

 _block = ^(){
     NSLog(@"string %@", self.string);
 };

 上面代码中block是会对内部的成员变量进行一次retain， 即self会被retain一次。

 对于block 使用 成员变量self.string来说，block内部是直接强引用self的。也就是block持有了self，在这里bock又作为self的一个成员被持有，就会导致循环引用和内存泄露。
 修改方案很简单：

 新建一个__block scope的局部变量，并把self赋值给它，而在block内部则使用这个局部变量来进行取值，上面说过：__block标记的变量是不会被自动retain的。
 __block ViewController *controller = self;
  
 _block = ^(){
     NSLog(@"string %@", controller.string);
 };

 4. block 基本使用

 当block定义完成后，我们除了可以像使用一般函数的方式来直接调用它以外，还可以有其他妙用，这些灵活的应用才是block最为强大的地方。

 (1) block 作为函数参数

 我们可以像使用一般函数使用参数的方式将block以函数参数的型式传入函数中，在这种情况下，大多数我们使用block的方式将不会倾向定义一个block，而是直接以内嵌的方式来将block传入，这也是目前新版SDK中主流的做法

 下面的例子中，block本身就是函数参数的一部分

 char *myCharacters[ 3 ] = { "TomJohn" , "George" , "Charles Condomine" };
  
 qsort_b (myCharacters, 3 , sizeof ( char *), ^( const void *l, const void *r)
 {
     //需要类型强转下
     char *left = *( char **)l;
     char *right = *( char **)r;
     return strncmp (left, right, 1 );
 } // 这里是block 的终点
 );
 // 最后的结果为：{"Charles Condomine", "George", "TomJohn"}

 (2) Block当作方法的参数

 // 所有的资料
 NSArray *array = [ NSArray arrayWithObjects : @"A" , @"B" , @"C" , @"A" , @"B" , @"Z" , @"G" , @"are" , @" Q" ,nil ];
  
 // 我们只要这个集合内的资料
 NSSet *filterSet = [ NSSet setWithObjects : @"A" , @"B" , @"Z" , @"Q" , nil ];
 BOOL (^test)( id obj, NSUInteger idx, BOOL *stop);
 test = ^ ( id obj, NSUInteger idx, BOOL *stop) {
     // 只对前5 笔资料做检查
     if (idx < 5 )
     {
         if ([filterSet containsObject : obj])
         {
             return YES ;
         }
     }
  
     return NO ;
 };
  
 NSIndexSet *indexes = [array indexesOfObjectsPassingTest :test];
 NSLog ( @"indexes: %@" , indexes);
 // 结果：indexes: <NSIndexSet: 0x6101ff0>[number of indexes: 4 (in 2 ranges), indexes: (0-1 3-4)]
 // 前５笔资料中，有４笔符合条件，它们的索引值分别是0-1, 3-4
 
 
 (3)OC方法中block实例

 A. sortedArrayUsingComparator:

 //这里面block代码块直接内嵌作为方法的参数
 NSArray *sortedArray = [array sortedArrayUsingComparator: ^(id obj1, id obj2) {
     //左边大于右边，降序
     if ([obj1 integerValue] > [obj2 integerValue])
     {
         return (NSComparisonResult)NSOrderedDescending;
     }
  
     //右边大于左边，升序
     if ([obj1 integerValue] < [obj2 integerValue])
     {
         return (NSComparisonResult)NSOrderedAscending;
     }
  
     //相同
     return (NSComparisonResult)NSOrderedSame;
 }];
 
 // 使用Block进行排序
 
 // 不可变数组
 NSArray *array = @[@"a", @"z", @"f"];
 NSComparator blockCMP = ^(id obj1, id obj2) {
 //        return [obj1 compare:obj2]; // 升序
     return -[obj1 compare:obj2]; // 降序
 };
 NSArray *newArr = [array sortedArrayUsingComparator:blockCMP];
 blockPrint(newArr);
 // 直接方法
 NSArray *nnArr = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
     return [obj1 compare:obj2];
 }];
 blockPrint(nnArr);
 
 // 可变数组
 NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
 [mArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
     return [obj1 compare:obj2];
 }];
 blockPrint(mArr);

 B. enumerateObjectsUsingBlock

 通常enumerateObjectsUsingBlock: 和 (for(… in …)在效率上基本一致，有时会快些。主要是因为它们都是基于 NSFastEnumeration实现的。快速迭代在处理的过程中需要多一次转换，当然也会消耗掉一些时间. 基于Block的迭代可以达到本机存储一样快的遍历集合. 对于字典同样适用。

 注意”enumerateObjectsUsingBlock” 修改局部变量时， 你需要声明局部变量为 __block 类型.

 enumerateObjectsWithOptions:usingBlock: 支持并发迭代或反向迭代，并发迭代时效率也非常高.

 对于字典而言, enumerateObjectsWithOptions:usingBlock 也是唯一的方式可以并发实现恢复Key-Value值.

 示例代码：

 //定义一个可变数组
 NSMutableArray *test = [NSMutableArray array];
  
 //向数组中添加元素
 for (int i= 0; i < 10000; i++)
 {
     [test addObject:@"i"];
 }
  
 //迭代数组输出
 [test enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         NSLog(@"%@",obj);
 }];

 5. block内存管理

 (1)堆(Stack)和栈(Heap)

 heap和stack是内存管理的两个重要概念。这里指的是内存的分配区域。

 stack的空间由操作系统进⾏行分配。
 在现代操作系统中,一个线程会分配⼀个stack. 当一个函数被调用,一个stack frame(栈帧)就会被压到stack里。里包含这个函数涉及的参数,局部变量,返回地址等相关信息。当函数返回后,这个栈帧就会被销毁。⽽这一切都是自动的,由系统帮我们进行分配与销毁。对于程序员是透明的,我们不需要手动调度。
 .
 heap的空间需要手动分配。 heap与动态内存分配相关,内存可以随时在堆中分配和销毁。我们需要明确请求内存分配与内存销毁。 简单来说,就
 是malloc与free.
 (2)Objective-C中的Stack和Heap

 首先所有的Objective-C对象都是分配在heap的。 在OC经典的内存分配与初始化：

  NSObject *obj = [[NSObject alloc] init];

 一个对象在alloc的时候,就在Heap分配了内存空间。 stack对象通常有速度的优势,⽽且不会发生内存泄露问题。那么为什么OC的对象都是分配在heap的呢? 原因在于:

 stack对象的⽣生命周期所导致的问题。例如一旦函数返回,则所在的stack frame就会被摧毁。那么此时返回的对象也 会一并摧毁。这个时候我们去retain这个对象是无效的。因为整个stack frame都已经被摧毁了。简单⽽言就是stack 对象的⽣命周期不适合Objective-C的引用计数内存管理⽅方法。
 .
 stack对象不够灵活,不具备足够的扩展性。创建时⻓度已经是固定的,⽽stack对象的拥有者也就是所在的stack frame
 我们知道block 在使用@property定义时，官方建议我们使⽤用copy修饰符

 // 定义一个块代码的属性，block属性需要用 copy
 @property (nonatomic, copy) void (^completion)(NSString *text);

 虽然在ARC时代已经不需要再显式声明了,使用strong是没有问题的,但是仍然建 议我们使⽤copy以显示相关拷贝⾏为。

 (3)为什么要使用copy？！

 其实Objective-C是有它的Stack object的。那就是block。

 在Objective-C语⾔言中,⼀一共有3种类型的block:

 _NSConcreteGlobalBlock 全局的静态block,不会访问任何外部变量。
 _NSConcreteStackBlock 保存在栈中的block,当函数返回时会被销毁。
 _NSConcreteMallocBlock 保存在堆中的block,当引⽤用计数为0时会被销毁。
 这⾥我们主要基于内存管理的角度对它们进行分类。

 NSConcreteGlobalBlock,这种不捕捉外界变量的block是不需要内存管理的,这种block不存在于Heap或是Stack⽽是作为代码片段存在,类似于C函数。
  
 NSConcreteStackBlock,需要涉及到外界变量的block在创建的时候是在stack上⾯分配空间的,也就是⼀旦所在函数返回,执行弹栈,则会被摧毁。这就导致内存管理的问题,如果我们希望保存这个block或者是返回它,如果没有做进⼀步的copy处理,则必然会出现问题。
 
 举个栗子,在手动管理引⽤计数时,如果在exampleD_getBlock方法返回block 时没有执行[[block copy] autorelease]的操作,则方法执行完毕后,block就会被销毁, 返回block是无效的。

 //定义了一个block
 typedef void (^dBlock)();
  
 dBlock exampleD_getBlock() {
     char d = 'D';
     return ^{
         printf("%c\n", d);
     };
 }
  
 void exampleD()
 {
     exampleD_getBlock();
 }
 
 NSConcreteMallocBlock,因此为了解决block作为Stack object的这个问题,我们最终需要把它拷⻉到堆上来。

 ￼拷贝到堆后,block的⽣命周期就与⼀般的OC对象⼀样了,我们通过引用计数来对其进行内存管理。

 ￼￼现在我们知道为么么要Copy了吧-_-

 block在创建时是stack对象,如果我们需要在离开当前函数仍能够使用我们创建的block。我们就需要把它 拷⻉到堆上以便进行以引用计数为基础的内存管理。
 在ARC模式下，系统帮助我们完成了copy的⼯作。在ARC下,即使你声明的修饰符是strong,实际上效果是与声明为copy一样的。 因此在ARC情况下,创建的block仍然是NSConcreteStackBlock类型,只不过当block被引用或返回时,ARC帮助我们完成了copy和内存管理的工作。

 总结

 在ARC下,我们可以将block看做⼀一个正常的OC对象,与其他对象的内存管理没什么不同。MRC下要使用 Block_copy()和 Block_release 来管理内存。
 (4)再来一个栗子

 上面讲到ARC下， block在被引用或返回时类型会由NSConcreteStackBlock转换为 NSConcreteHeapBlock,那在MRC环境下该怎么办呢。

 block在创建的时候，它的内存是分配在栈(stack)上，而不是在堆(heap)上。
 我们在viewDidLoad中创建一个_block：

 - (void)viewDidLoad
 {
     [superviewDidLoad];
  
     int number = 1;
     _block = ^(){
  
     NSLog(@"number %d", number);
     };
 }

 并且在一个按钮的事件中调用了这个block：

 - (IBAction)testDidClick:(id)sender {
     _block();
 }

 此时如果按了按钮之后就会导致程序崩溃，解决这个问题的方法很简单

 在创建完block的时候需要调用 Block_copy函数。它会把block从栈上移动到堆上，那么就可以在其他地方使用这个block了。Block_copy实际上是一个宏，如下：
 #define Block_copy(...) ((__typeof(__VA_ARGS__))_Block_copy((const void *)(__VA_ARGS__)))
 
 使用后，使用 Block_release，从堆中释放掉
 修改代码如下：

 _block = ^(){
     NSLog(@"number %d", number);
 };
  
 _block = Block_copy(_block);

 同理，特别需要注意的地方就是在把block放到集合类当中去的时候，如果直接把生成的block放入到集合类中，是无法在其他地方使用block，必须要对block进行copy。示例如下：

 [array addObject:[[^{ NSLog(@"hello!"); }  copy]  autorelease]];
 
 Q:为什么不使用简单的copy方法 而是 Blockcopy呢？

 因为blcok是复杂的匿名函数，简单的copy在有些时候不能实现准确的copy，详细就要看各自的C源码了
 6. 视图控制器反向传值

 使用Block的地方很多，其中传值只是其中的一小部分，下面介绍Block在两个界面之间的传值：

 先说一下思想：

 首先，创建两个视图控制器，在第一个视图控制器中创建一个UILabel和一个UIButton，其中UILabel是为了显示第二个视图控制器传过来的字符串，UIButton是为了push到第二个界面。

 第二个界面的只有一个UITextField，是为了输入文字，当输入文字，并且返回第一个界面的时候，当第二个视图将要消失的时候，就将第二个界面上TextFiled中的文字传给第一个界面，并且显示在UILabel上。

 其实核心代码就几行代码：

 在第二个视图控制器的.h文件中定义声明Block属性

 typedef void (^ReturnTextBlock)(NSString *showText);
  
 @interface TextFieldViewController : UIViewController
  
 @property (nonatomic, copy) ReturnTextBlock returnTextBlock;
  
 - (void)returnText:(ReturnTextBlock)block;
  
 @end

     第一行代码是为要声明的Block重新定义了一个名字
  
 ReturnTextBlock
     这样，下面在使用的时候就会很方便。
  
     第三行是定义的一个Block属性
  
     第四行是一个在第一个界面传进来一个Block语句块的函数，不用也可以，不过加上会减少代码的书写量
 实现第二个视图控制器的方法

 - (void)returnText:(ReturnTextBlock)block {
   self.returnTextBlock = block;
 }
 - (void)viewWillDisappear:(BOOL)animated {
  
   if (self.returnTextBlock != nil) {
     self.returnTextBlock(self.inputTF.text);
   }
 }

 其中inputTF是视图中的UITextField。

 第一个方法就是定义的那个方法，把传进来的Block语句块保存到本类的实例变量returnTextBlock（.h中定义的属性）中，然后寻找一个时机调用，而这个时机就是上面说到的，当视图将要消失的时候，需要重写：

 - (void)viewWillDisappear:(BOOL)animated;
 方法。

 在第一个视图中获得第二个视图控制器，并且用第二个视图控制器来调用定义的属性

 如下：

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   TextFieldViewController *tfVC = segue.destinationViewController;
  
   [tfVC returnText:^(NSString *showText) {
     self.showLabel.text = showText;
   }];
 }
 
 可以看到代码中的注释，系统告诉我们可以用

 [segue destinationViewController]

 来获得新的视图控制器，也就是我们说的第二个视图控制器。

 这时候上面（第一步中)定义的那个方法起作用了，如果你写一个[tfVC return Text按回车 ,系统会自动提示出来一个：

 tfVC returnText:<#^(NSString *showText)block#>
 
 的东西，我们只要在焦点上回车，就可以快速创建一个代码块了，大家可以试试。这在写代码的时候是非常方便的。

 面试题：

 __block什么时候用
 当需要在block 中修改外部变量时使用，当需要访问内部成员变量时。
 2.在block里面, 对数组执行添加操作, 这个数组需要声明成 __block吗?

 当然不需要，因为数组可以理解为指针，在block中对数组进行添加操作，只是改变了指针指向的值，而没有修改外部数组地址，详细参见block访问成员变量示例3
 3.在block里面, 对NSInteger进行修改, 这个NSInteger是否需要声明成__blcok

 必须需要，NSInteger -> typedef long NSInteger; 这货披着OC的外衣，其实就是一个基本类型，基本类型在没有static 等的保护下，当然需要__block
 悄悄告诉你哦，block在iOS的面试中是非常重要的，如果你能把上面讲解的内容理解了，那么就仰天长啸出门
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [DHBlockKnowledgePracticeViewController getMyBestMethod:^(NSDictionary * _Nonnull dict) {
//        NSLog(@"输出--%@",dict);
//    }];
//    [self showIndex:10];


}

- (void)returnText:(KnowledgePracticeBlock)block {
    self.returnTextBlock = block;
}

- (void)backBlockNilMetnod{
    if (self.returnTextBlock){
        self.returnTextBlock(@"backBlockNilMetnod");
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

+ (void)getMyBestMethod:(void (^_Nullable)(NSDictionary * _Nonnull dict))then {
    NSDictionary* dictA = @{@"key":@"value"};
    if (then) {
        then(dictA);
    }
}

- (void)getMyBestMethod:(void (^_Nonnull)(NSString * _Nonnull))then {
    NSString* str = @"HelloWorld";
    if (then) {
        then(str);
    }
}

- (void)showIndex:(NSInteger)index {
    __block NSInteger i = index;
    void (^showEvent)(NSInteger) = ^(NSInteger aIndex) {
        i = aIndex + i;
        NSLog(@"%ld", (long)aIndex);
    };
    NSLog(@"first %ld", (long)i);
    showEvent(10);
    index = i;
    NSLog(@"last %ld---%ld", (long)i,index);
}

- (void)test1 {
    // 有参数，有返回值
    void (^ MtTestBlock)(int,int)=^(int a,int b){
        int v= a+b;
        NSLog(@"本地传值内容:%d",v);
    };
    MtTestBlock(10,20);
}

- (void)test2 {
    //同时使用__weak 和 __strong：其中strongSelf 是一个临时变量，在 myBlock 的作用域内，即内部 block 执行完就释放strongSelf，这种方式属于打破 self 对 block 的强引用，依赖于中介者模式，属于自动置为nil，即自动释放。
    __weak typeof(self) weakSelf = self;
    void (^TestNumberC)(int)=^(int x){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.numC = 1000;
        NSLog(@"C2、num的h值是 %d",strongSelf.numC);
    };
    TestNumberC(86);
}

- (void)test3 {
    // 有参数，无返回值，声明和定义
    void(^MyblockTwo)(int a) = ^(int a){
        NSLog(@"@ = %d我就是block，有参数，无返回值", a);
    };
    MyblockTwo(1);
}

- (void)test4 {
    // 无参数，无返回值，声明和定义
    void( ^MyBlockOne)(void) = ^(void){
        NSLog(@"无参数，无返回值");
    };
    // block的调用
    MyBlockOne();
}

- (void)test5 {
    //无参数，有返回值
    int(^MyblockFour)(void) = ^{
        NSLog(@"无参数，有返回值");
        return 45;
    };
    MyblockFour();
}

- (void)test6 {
    //（使用函数内变量） __NSMallocBlock__
    self.myBlockOne = ^int(int a, int b){
        return a + b;
    };
    self.myBlockOne(10, 20);
    
    void (^MtTestBlock)(int,int)=^(int a,int b){
        int v = a+b;
        NSLog(@"本地传值内容:%d",v);
    };
    MtTestBlock(10,20);
}

//TODO: 为什么Block语法中不能使用数组？
//因为结构体中的成员变量与自动变量类型完全相同，所以结构体中使用数组截取数组值，而后调用时再赋值给另一个数组。也就是数组赋值给数组，这在C语言中是不被允许的。
//默认情况
- (void)test7 {
    /*
     所谓捕获外部变量，意思就是在block内部，创建一个变量来存放外部变量，这就叫做捕获。
     auto变量：自动变量，离开作用域就会销毁，一般我们创建的局部变量都是auto变量，比如 int age = 10，系统会在默认在前面加上auto int age = 10。
     对于 block 外的变量引用，block 默认是将其复制到其数据结构中来实现访问的。也就是说 block 的自动变量截获只针对 block 内部使用的自动变量，不使用则不截获，因为截获的自动变量会存储于block的结构体内部，会导致block体积变大。
     特别要注意的是默认情况下block只能访问不能修改局部变量的值。
     */
    //__NSGlobalBlock__ 没有访问auto变量 什么也不做
    //__NSMallocBlock__ NSMallocBlock调用了copy 引用计数增加
    //__NSStackBlock__ 访问了auto变量 从栈复制到堆上
    //3.自动进行copy的情况
    //在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上，比如以下情况
    //block作为函数返回值时
    //将block赋值给__strong指针时
    //block作为Cocoa API中方法名含有usingBlock的方法参数时
    //block作为GCD API中方法参数时

    int age = 10;
    void (^myBlockBlock)(void) = ^{
        NSLog(@"age = %d", age);
    };
    age = 18;
    myBlockBlock();
    //使用clang将OC代码转换为C++文件:xcrun -sdk iphonesimulator clang -rewrite-objc main.m ；
    /*
     struct __main_block_impl_0 {
       struct __block_impl impl;
       struct __main_block_desc_0* Desc;
       int age;
       __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
       int age = __cself->age; // bound by copy

             NSLog((NSString *)&__NSConstantStringImpl__var_folders_y4_v4b6f3rs4qx_91hzqc20k9n40000gn_T_main_580a5b_mi_0, age);
         }

     
     int age = 10;
     void (*myBlockBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age));
     age = 18;
     ((void (*)(__block_impl *))((__block_impl *)myBlockBlock)->FuncPtr)((__block_impl *)myBlockBlock);
     */
}

//__block 修饰的外部变量
- (void)test8 {
    /*
     对于用__block 修饰的外部变量引用，block 是复制其引用地址来实现访问的。
     block可以修改__block 修饰的外部变量的值。
     */
    __block int age = 10;
    void (^myBlock)(void) = ^{
        NSLog(@"age = %d",age);
    };
    age = 18;//编译器会将__block变量包装成一个对象，直接捕获到block内部，并进行指针传递，所以能够修改其值
    myBlock();
    //为什么使用__block 修饰的外部变量的值就可以被block修改呢?
    /*
     使用clang将OC代码转换为C++文件:xcrun -sdk iphonesimulator clang -rewrite-objc main.m ；
     会发现一个局部变量加上__block修 饰符后竟然跟block-样变成了一个__Block_byref_age_0结构体类型的自动变量实例。如下所示：
     */
    /*
     struct __Block_byref_age_0 {
       void *__isa;
     __Block_byref_age_0 *__forwarding;
      int __flags;
      int __size;
      int age;
     };

     struct __main_block_impl_0 {
       struct __block_impl impl;
       struct __main_block_desc_0* Desc;
       __Block_byref_age_0 *age; // by ref
       __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
       __Block_byref_age_0 *age = __cself->age; // bound by ref

             NSLog((NSString *)&__NSConstantStringImpl__var_folders_y4_v4b6f3rs4qx_91hzqc20k9n40000gn_T_main_3e0ffa_mi_0,(age->__forwarding->age));
         }
     static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->age, (void*)src->age, 8);}

     static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->age, 8);}

     */
    /*
     
     __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};
     void (*myBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age, 570425344));
     (age.__forwarding->age) = 18;
     ((void (*)(__block_impl *))((__block_impl *)myBlock)->FuncPtr)((__block_impl *)myBlock);
     此时我们在block内部访问age变量则需要通过一个叫__forwarding的成员变量来间接访问age变量。
     带__block的自动变量和静态变量就是直接地址访问，所以在Block里面可以直接改变变量的值。
     */

}

- (void)test9 {
    //block内部新建一个成员来存储外部变量的值
    //auto变量含义：离开作用域（大括号），Block的内存地址显示在栈区,栈区的特点就是创建的对象随时可能被销毁(会自动释放的变量,),一旦被销毁后续再次调用空对象就可能会造成程序崩溃,在对block进行copy后,block存放在堆区
    //对于age是捕获到内部，把外部age的值存起来，而对于height，是把外部变量的指针保存起来,
    //对于static height值， block在访问static变量（局部变量）时，block内部会捕获到外部变量的地址值，后面修改外部static变量值的时候，（通过指针变量所指向的内存的值）地址访问到的是最新修改后的值。
    //思考：为什么会出现这两种情况？原因很简单，因为auto是自动变量，出了作用域后会自动销毁的，如果我们不保留他的指针，就会存在访问野指针的情况，所以去要捕获他并把值保存起来。
    //为什么局部变量需要捕获，全局变量不需要？
    //局部变量需要跨函数访问，而且随时可能会被销毁所以需要提前捕获。
    //全局变量随时都可以访问，且一直存在，所以不需要捕获。
    //auto 值传递
    //static 指针传递
    //全局变量 直接访问
    //成员变量与属性在block中调用时，需要被捕获吗？
    //因为调用成员变量与属性时，需要通过self来调用，而self对block来说是局部变量，所以是需要捕获的。
    
//    对象类型外部变量(需要捕获并指针传递，主要讨论强弱引用)
//    当block内部访问了对象类型的auto变量时
//    如果block是在栈上，将不会对auto变量产生强引用
//    如果block被拷贝到堆上
//    会调用block内部的copy函数
//    copy函数内部会调用_Block_object_assign函数
//    _Block_object_assign函数会根据auto变量的修饰符(_strong、_weak、_unsafe_unretained)做出相应的操作，类似于retain(形成强引用、弱引用)
//    如果block从堆上移除
//    会调用block内部的dispose函数
//    dispose函数内部会调用_Block_object_dispose函数
//    _Block_object_dispose函数会自动释放引用的auto变量，类似于release
//    函数        调用时机
//    copy函数    栈上的Block 复制到堆时
//    dispose函数 堆上的Block 被废弃时

    auto int age = 10;
    static int height = 20;
    void (^block)(void) = ^{
        NSLog(@"age is %d, height is %d",age,height);
    };
    age = 40;//block在访问auto变量（局部变量）时，block内部会捕获到外部变量的值，后面修改外部auto变量的值，block内部的值不会随着改变而改变
    height = 40;
    block();
    /*
     使用clang将OC代码转换为C++文件:xcrun -sdk iphonesimulator clang -rewrite-objc main.m ；
     struct __main_block_impl_0 {
       struct __block_impl impl;
       struct __main_block_desc_0* Desc;
       int age;//定义 age 变量
       int *height;//定义一个指针变量,存放外部变量的指针
       __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int *_height, int flags=0) : age(_age), height(_height) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
       int age = __cself->age; // bound by copy
       int *height = __cself->height; // bound by copy //取出指针变量所指向的内存的值

             NSLog((NSString *)&__NSConstantStringImpl__var_folders_y4_v4b6f3rs4qx_91hzqc20k9n40000gn_T_main_6d7e83_mi_0,age,(*height));
         }

     
     auto int age = 10;
     static int height = 20;
     void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age, &height));
     age = 20;
     height = 20;
     ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
     */
    
}
void(^block)(void);
void test() {
    int age = 10;
    static int height = 20;
    // 在block内部访问 age , height
    block = ^{
        NSLog(@"age is %d, height is %d",age,height);
    };
    age = 40;
    height = 40;
}

- (void)test10 {
    test();
    // test调用后,age变量就会自动销毁,如果block内部是保留age变量的指针,那么我们在调用block()时,就出现访问野指针
    block();
    
    NSLog(@"block : %@", ^{NSLog(@"block");});      // __NSGlobalBlock__
    
    NSString *str3 = @"1234";
    NSLog(@"block is %@", ^{NSLog(@":%@", str3);});     // __NSStackBlock__
}

- (void)test11 {
    //__weak与__strong搭配使用（weak- strong- dance 强弱共舞,能保证在整个block环境使用中不会被释放，如下延时操作案例中）
    BlockObject *object = BlockObject.alloc.init;
    object.name = @"BlockObject";
    __weak typeof(object) weakSelf = object;
    object.selfBlock = ^{
        __strong typeof(object) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"my name is = %@",strongSelf.name);
        });
    };
    //weakSelf 是为了block不持有self，避免Retain Circle循环引用。在 Block 内如果需要访问 self 的方法、变量，建议使用 weakSelf。
    
    //strongSelf的目的是因为一旦进入block执行，假设不允许self在这个执行过程中释放，就需要加入strongSelf。block执行完后这个strongSelf 会自动释放，没有不会存在循环引用问题。如果在 Block 内需要多次 访问 self，则需要使用 strongSelf。

}
/*
 该函数返回的Block是配置在栈上的，所以返回函数调用时，Block变 量作用域就结束了，Block会被废弃。
 但在ARC有效，这种情况编译器会自动完成复制。
 在非ARC情况下则需要开发者调用copy方法手动复制，由于开发中几乎都是ARC模式，所以手动复制内容不再过多研究。
 将Block从栈上复制到堆上相当消耗CPU，所以当Block设置在栈上也能够使用时，就不要复制了，因为此时的复制只是在浪费CPU资源。
 Block的复制操作执行的是copy实例方法。不同类型的Block使用copy方法的效果如下表:
 */
/*
 根据表得知，Block在 堆中copy会造成引用计数增加，这与其他Objective-C对象是一样的。虽然Block在栈中也是以对象的身份存在，但是栈块没有引用计数，因为不需要，我们都知道栈区的内存由编译器自动分配释放。
 不管Block存诸域在何处，用copy方 法复制都不会引起任何问题。在不确定时调用copy方法即可。
 在ARC有效时，多次调用copy方法完全没有问题:
     // 经过多次复制，变量blk仍然持有Block的强引用，该Block不会被废弃。
     blk = [[[[blk copy] copy] copy] copy];
 */
typedef int (^blk_t)(int);
//形参rate被拷贝进了blk_t
blk_t func(int rate) {
    return ^(int count) {
        return rate * count;
    };
}
//对象 self 作为参数：将对象 self 作为参数，提供给 block 内部使用，不会有引用计数问题。
- (void)test12 {
    /* 不推荐
     __block修饰变量：这种方式同样依赖于中介者模式，属于手动释放，是通过__block修饰对象，主要是因为__block修饰的对象是可以改变的，需要注意的是这里的 block 必须调用，如果不调用 block，vc 就不会置空，那么依旧是循环引用，self 和 block 都不会被释放。
         __block ViewController *vc = self;
         self.myBlock = ^(void){
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 NSLog(@"%@",vc.name);
                 // 手动释放
                 vc = nil;
             });
         };
         self.myBlock();
     */
    self.myBlock = ^(DHBlockKnowledgePracticeViewController *vc){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",vc.numC);
            vc.numC = _xxx = 10;
        });
    };
    self.myBlock(self);
    //typedefBlock（函数体外自定义的Block） __NSGlobalBlock__
    ClassBlockObject block = ^(DHBlockKnowledgePracticeViewController *class){
        NSLog(@"输出--%@",class);
    };
    NSLog(@"输出--%@",block);
    
}

- (void)test13 {
    DHProxy *proxy = [DHProxy alloc];
    
    BlockObject *object1 = BlockObject.alloc.init;
    ResponseObject *object2 = ResponseObject.alloc.init;
    
    [proxy transformObjc:object1];
    [proxy performSelector:@selector(theResponse)];
    
    [proxy transformObjc:object2];
    [proxy performSelector:@selector(theResponseSubFunc)];
    
    //通过 YDWProxy 解决定时器中 self 的强引用问题：
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:[DHProxy proxyWithObjc:self] selector:@selector(print) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerFunc {
    /**
     NSTimer会准时触发事件吗
     
     答案是否定的，而且有时候你会发现实际的触发时间跟你想象的差距还比较大。NSTimer不是一个实时系统，因此不管是一次性的还是周期性的timer的实际触发事件的时间可能都会跟我们预想的会有出入。差距的大小跟当前我们程序的执行情况有关系，比如可能程序是多线程的，而你的timer只是添加在某一个线程的runloop的某一种指定的runloopmode中，由于多线程通常都是分时执行的，而且每次执行的mode也可能随着实际情况发生变化。
     假设你添加了一个timer指定2秒后触发某一个事件，但是签好那个时候当前线程在执行一个连续运算(例如大数据块的处理等)，这个时候timer就会延迟到该连续运算执行完以后才会执行。重复性的timer遇到这种情况，如果延迟超过了一个周期，则会和后面的触发进行合并，即在一个周期内只会触发一次。但是不管该timer的触发时间延迟的有多离谱，他后面的timer的触发时间总是倍数于第一次添加timer的间隙。
     */
    /**
     + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
     
     Interval:设置时间间隔,以秒为单位,一个>0的浮点类型的值，如果该值<0,系统会默认为0.1
     
     target:表示发送的对象，如self
     
     selector:方法选择器，在时间间隔内，选择调用一个实例方法
     
     userInfo:此参数可以为nil，当定时器失效时，由你指定的对象保留和释放该定时器。
     
     repeats:当YES时，定时器会不断循环直至失效或被释放，当NO时，定时器会循环发送一次就失效。
     */
    
    //    timer1 = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRequest) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
    /**
     使用block的方法就直接在block里面写延时后要执行的代码
     + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block
     */
    //    timer2 = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"定时器开始。。。");
    //        count2 ++;
    //        labelName.text = [NSString stringWithFormat:@"计时器当前计数:%d",count2];
    //    }];
    //    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:NSRunLoopCommonModes];
    
    /**
     invocation:需要执行的方法
     + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;
     */
    //    NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(timerRequest)];
    //    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: sgn];
    //    [invocation setTarget: self];
    //    [invocation setSelector:@selector(timerRequest)];
    //    timer3 = [NSTimer timerWithTimeInterval:1.0 invocation:invocation repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:timer3 forMode:NSRunLoopCommonModes];
    
    /**
     scheduledTimerWithTimeInterval 自动加入到RunLoop自动执行
     + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
     */
    //    timer4 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRequest) userInfo:nil repeats:YES];
    
    /**
     自动加入到RunLoop自动执行
     + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
     */
    //    timer5 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"定时器开始。。。");
    //        count5 ++;
    //        labelName.text = [NSString stringWithFormat:@"计时器当前计数:%d",count5];
    //    }];
    /**
     自动加入到RunLoop自动执行
     + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;
     */
    //    NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(timerRequest)];
    //    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: sgn];
    //    [invocation setTarget: self];
    //    [invocation setSelector:@selector(timerRequest)];
    //    timer6 = [NSTimer scheduledTimerWithTimeInterval:1.0 invocation:invocation repeats:YES];
    
    /**
     启动定时器
     [NSDate distantPast];
     停止定时器
     [NSDate distantFuture];
     //暂时停止定时器
     //[timer setFireDate:[NSDate distantFuture]];
     //重新开启定时器
     //[timer setFireDate:[NSDate distantPast]];
     //永久通知定时器
     //[timer invalidate];
     //timer = nil;
     - (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(nullable id)ui repeats:(BOOL)rep;
     */
    //    timer7 = [[NSTimer alloc]initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(timerRequest) userInfo:nil repeats:YES];
    //    [[NSRunLoop mainRunLoop]addTimer:timer7 forMode:NSDefaultRunLoopMode];
    
    
    /**
     - (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
     */
    //    timer8 = [[NSTimer alloc]initWithFireDate:[NSDate distantPast] interval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"定时器开始。。。");
    //        count8 ++;
    //        labelName.text = [NSString stringWithFormat:@"计时器当前计数:%d",count8];
    //    }];
    //    [[NSRunLoop mainRunLoop]addTimer:timer8 forMode:NSDefaultRunLoopMode];
    //测试
    //    NSTimer *timeTest = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRequest) userInfo:nil repeats:YES];
    //    [self performSelector:@selector(simulateBusy:) withObject:@"ojbcet" afterDelay:3];
    
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[WeakProxy proxyWithTarget:self] selector:@selector(timerStart:) userInfo:nil repeats:YES];
    //    self.timer = [TempTarget scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
}

- (void)print {
    NSLog(@"输出--%@",@"我被释放了");
}
typedef void (^blockSave)(void);
- (void)test14 {
    // 当全局block引用了外部变量，ARC机制优化会将Global的block,转为Malloc（堆）的block进行调用。
    __block int age = 20;
    int *ptr = &age;
    // ARC下
    blockSave x = ^{
        NSLog(@"(++age):%d", ++age);    // 变量前不加__block的情况下，会报错，变量的值只能获取，不能更改
    };
    blockSave y = [x copy];
    y();
    NSLog(@"x():%@, y():%@ , (*ptr):%d", x, y, *ptr);
}

- (void)test15{
    //    __block UIImage *image;
    //    dispatch_sync_on_main_queue(^{
    //        image = [UIImage imageNamed:@"Resource/img"];
    //    });
}

//YYKit中提供了一个同步扔任务到主线程的安全方法：
static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
    NSLog(@"1、执行");
        if (pthread_main_np()) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2、执行");
        });
        NSLog(@"3、执行");
};

- (void)test16 {
    
    //函数式编程
    //把Block当做函数的参数，可以把我们的逻辑和函数放在调用时候的block里面，而不是方法内部。这样会让我们在写代码的时候，把相关的逻辑都放在一起，提高了开发效率和程序的可读性。这其实就是函数式编程思想。函数式编程在很多第三方框架中都有明显的体现，比如说我们频繁使用的AFNetWorking、Masonry
    [self eatWith:^(NSDictionary *dic) {
        NSLog(@"dic %@",dic);
    }];
    //*格式：void (^block名称)(参数列表) = ^ (参数列表) { // 代码实现; }
    void(^block)(int i) = self.run;
    block(1);
    //上面这两行代码可以合并为下面这一行
    self.run(10);//有没有发现这个调用和block作为属性时是一样的，下面会继续分析
    
    //链式调用
    self.travel(@"重庆").travel(@"北京");
    ///TODO: Block Pointer是这样定义的：
    //回传值 (^名字) (参数列);
    int (^my2Block)(void);
    int x;
    x = 10;
    my2Block = ^(void)
    {
        return x;
    };
    logBlock(my2Block);
    
    //声明一个名字为square的Block Pointer，其所指向的Block有一个int输入和int输出
    int (^square)(int);
     
    //block 指针square的内容
    square = ^(int a){ return a*a ; };
     
    //调用方法，感觉是是不是很像function的用法？
    int result = square(5);

    NSLog(@"%d", result);
    ///TODO: block基本定义方式
    //*格式：返回类型 (^block名称)(参数列表) = ^ 返回类型 (参数列表) { // 代码实现; }
    int (^my1Block)(int , int) = ^int (int a, int b){
        return a+b;
    };
    [self sumBlock:my1Block];
    
    /*
    *1.最简单的定义方式:
    *格式：void (^myBlock)() = ^ { // 代码实现; }
    */
    void (^myBlock)(void) = ^ {
        NSLog(@"hello");
    };
     
    // 执行时，把block当成函数
    myBlock();
     
    /*
    *2.定义带参数的block:
    *格式：void (^block名称)(参数列表) = ^ (参数列表) { // 代码实现; }
    */
    void (^sumBlock)(int, int) = ^ (int x, int y) {
        NSLog(@"%d", x + y);
    };
     
    sumBlock(10, 20);
     
    /*
    *3.定义带返回值的block
    *格式：返回类型 (^block名称)(参数列表) = ^ 返回类型 (参数列表) { // 代码实现; }
    */
    int (^sumBlock2)(int, int) = ^ int (int a, int b) {
        return a + b;
    };
     
    NSLog(@"%d", sumBlock2(4, 8));

    ///TODO: block 指针
    ///回传值 (^名字) (参数列);
    ///声明一个名字为square的Block Pointer，其所指向的Block有一个int输入和int输出
    int (^square1)(int);
     
    //block 指针square的内容
    square1 = ^(int a){ return a*a ; };
     
    //调用方法，感觉是是不是很像function的用法？
    int result1 = square1(5);
    NSLog(@"%d", result1);
    NSLog(@"内联函数 %@",intToString(123));

    /*
     用typedef先声明类型,再定义变量进行赋值
     typedef int (^MySum)(int,int);
     MySum sum = ^(int a,int b)
      {
           return a + b;
     }
     */
//    block 访问外部变量
//   但是block使用有个特点，Block可以访问局部变量，但是不能修改：
//   int summ = 10;
//   int (^MyBlocks)(int) = ^(int num)
//   {
//       summ++;//编译报错
//        return num * summ;
//   };
//    如果要修改就要加关键字 __block （下面详细说明）:
//    __block int sum =10;
//    (5) block 与函数指针
//
//    下面比较下函数指针与block异同：
//
//    定义函数指针 int (*myFn)();
//    调用函数指针 (*myFn)(10, 20);
//
//    定义Block int (^MyBlocks)(int,int);
//    调用Blocks MyBlocks(10, 20);
//
//    3. block访问外部变量
//
//    block 访问外部变量有几个特点必须知道：
//
//    block内部可以访问外部变量；
//    默认情况下block内部不能修改外面的局部变量；
//    给局部变量加上关键字_block,这个局部变量就可以在block内部修改；
//    block中可以访问外部变量。但是不能修改它，否则编译错误。但是可以改变全局变量、静态变量(static)、全局静态变量。
//    上面的特点是有原因滴：
//
//    A. 为何不让修改变量：这个是编译器决定的。理论上当然可以修改变量了，只不过block捕获的是外部变量的副本，名字一样。为了不给开发者迷惑，干脆不让赋值。道理有点像：函数参数，要用指针，不然传递的是副本（大家想起那个经典的两个数调换值的问题了吧）。
//
//    B. 可以修改静态变量的值。静态变量属于类的，不是某一个变量。所以block内部不用调用cself指针。所以block可以调用。
//    (1) __block存储类型
//
//    通过__block存储类型修饰符， 变量在block中可被修改。__block存储跟register、auto和static存储类型相似（但是之间互斥），用于局部变量。__block变量存储在堆区，因此，这个block使用的外部变量，将会在栈结束被留下来。
//
//    从优化角度考虑，block存储在栈上，如果block被拷贝（通过Block_copy或者copy）,变量被拷贝到堆。因此__block变量的地址就会改变。
//
//    __block变量还有两个限制，他们不能是可变数组(NSMutableArray)，不能是结构体(structure)。
//
//    __block 变量的内部实现要复杂许多，__block 变量其实是一个结构体对象，拷贝的是指向该结构体对象的指针
    //声明
    void(^timerblock)(NSString *) = ^(NSString *dicdic){
        //实现
        NSLog(@"输出--%@",dicdic);
    };
    NSLog(@"block--%@",[DHBlockKnowledgePracticeViewController block:timerblock]);
}
//block作为方法参数
//Block作为参数时，blockname不需要写在^后面，直接写在括号后面
- (void)eatWith:(void (^)(NSDictionary *dic))block {
    block(@{@"name":@"234"});
}
//block作为方法的返回值
//Block作为返回值(block作为方法的返回值)
- (void (^)(int i))run {
    return ^(int i){
        NSLog(@"我走了%d米",i);
    };
}
NSString* (^intToString)(NSUInteger) = ^(NSUInteger paramInteger){
    NSString *result = [NSString stringWithFormat:@"%lu",(unsigned long)paramInteger];
    return result;
};
//链式调用方法
//后面带括号，说明方法的返回值是一个Block。
//调用方法肯定是对象才可以进行调用，说明Block的返回值是一个对象。
//点语法则说明这个方法没有参数。
//结合以上三点思考，我们可以得出一个结论，一个没有参数&有返回值&返回值是Block&Block的返回值是方法的调用者的方法，就可以实现链式调用：
- (DHBlockKnowledgePracticeViewController *(^)(NSString *))travel {
    return ^(NSString *city){
        NSLog(@"我去了%@",city);
        return self;
    };
}
void logBlock(int(^theBlock)(void)) {
    NSLog( @"Closure var X: %i", theBlock());
}
//Block可以作为函数参数或者函数的返回值,而其本身又可以带输入参数或返回值。
//苹果官方建议尽量多用block。在多线程、异步任务 、集合遍历、集合排序、动画转场用的很多
+ (NSString *)block:(void (^)(NSString *timer))block{
    NSString *param = @"测试block";
    if (block){
        block(param);
        return @"OK";
    }else{
        return @"NO";
    }
}
- (void)sumBlock:(int(^)(int i,int b))ppp{
    NSLog(@"输出--%i",ppp(10,20));
}
- (void)acb:(id)data,...NS_REQUIRES_NIL_TERMINATION{
    [self acb:nil,@"配置管理", nil];
}

- (void)test17 {
    /*先声明后定义的形式*/
    void(^NormalBlock5)(NSInteger);
    NormalBlock5 = ^void(NSInteger avlue)
    {
        NSLog(@"%ld", (long)avlue);
    };
    /*定义两遍，应该用后者吧*/
    NormalBlock5 = ^void(NSInteger avlue)
    {
        NSInteger nb = avlue * 2;
        NSLog(@"%ld", (long)nb);
    };
    NormalBlock5(25);
}

double func_runtime(double last, char* key) {
    clock_t now = clock();
    printf("time:%fs \t key:%s \n", (last != 0) ? (double)(now - last) / CLOCKS_PER_SEC : 0, key);
    return now;
}
CGFloat BNRTimeBlock (void (^block)(void)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (CGFloat)nanos / NSEC_PER_SEC;
}
CGFloat CodeTime (void (^block)(void)) {
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    block ();
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    return linkTime *1000.0;
}

- (void)test18 {
    Class cls =  NSClassFromString(@"DHBlockCallbackViewController");
    UIViewController *viewController = [[cls alloc] init];
    //没有参数 类方法  返回值为BOOL
    SEL selector1 = NSSelectorFromString(@"isWXAppInstalled");
    IMP imp1 = [cls methodForSelector:selector1];
    BOOL (*func1)(Class, SEL) = (BOOL (*)(Class,SEL))imp1;
    BOOL flag =  func1(cls,selector1);
    NSLog(@"--返回值：%d--",flag);
    
    // 调用实例化函数 有返回值
    typedef void(^voidmethod)(NSString *dic);
    SEL selector5 = NSSelectorFromString(@"textValueFunction:");
    IMP imp = [viewController methodForSelector:selector5];
    void (*func)(Class, SEL,voidmethod) = (void*)imp;
    if (viewController && [viewController respondsToSelector:selector5]) {
        func(cls,selector5,^(NSString *string){
            NSLog(@"%@",string);
        });
    }
    NSString* str =  ((NSString* (*)(id,SEL,NSString*))objc_msgSend)(viewController, NSSelectorFromString(@"textFunction:"),@"字符串参数");
    NSLog(@"----%@",str);
    //    void(^block)(void) = ^{
    //        NSLog(@"----");
    //    };
    //    weakSelf.block = block;
    //调用类函数 一个参数
    void(^infoBlock)(NSString *dic) = ^(NSString * infor){
        NSLog(@"%@",infor);
        infor = @"工程师";
        NSLog(@"%@",infor);
    };
    ((void(*)(id,SEL,id))objc_msgSend)([viewController class], NSSelectorFromString(@"numberInfor:"), infoBlock);
    
    //调用block属性
    void(^block)(NSString * infor) = self.occupation;
    
    ((void(*)(id,SEL,id))objc_msgSend)(viewController, NSSelectorFromString(@"setReception:"),block);
    
    ((void(*)(id,SEL,id))objc_msgSend)(viewController, NSSelectorFromString(@"setMyReturnTextBlock:"),block);
    NSLog(@"occupation %@",self.occupation);
    
    BOOL isWhiteSkinColor = ((BOOL(*)(id, SEL))objc_msgSend)(cls, @selector(isWhiteSkinColor));
    //等同于下面
    SEL selector = NSSelectorFromString(@"isWhiteSkinColor"); //类方法
    ((void (*)(id, SEL))[cls methodForSelector:selector])(cls, selector);
    //    if (!_controller) { return; }
    //    SEL selector = NSSelectorFromString(@"someMethod");
    //    IMP imp = [_controller methodForSelector:selector];
    //    void (*func)(id, SEL) = (void *)imp;
    //    func(_controller, selector);
    //等同于
    ((void (*)(id, SEL))[cls methodForSelector:selector])(viewController, selector);
    NSLog(@"isWhiteSkinColor %d",isWhiteSkinColor);
    
    id(*ins)(id, SEL) = (id(*)(id, SEL))objc_msgSend;
    id gm = ins([viewController class], NSSelectorFromString(@"isWhiteSkinColor"));
    //set方法
    ((id (*)(id, SEL, id))objc_msgSend)(gm, NSSelectorFromString(@"setNameP"),@"属性赋值");
    //get方法
    ((NSString* (*)(id, SEL,id ))objc_msgSend)(viewController,NSSelectorFromString(@"nameP:"),@"asdf");
    
    //调用类方法带block多参数的函数
    CustomEvent finishCall = ^(NSString* str){
        NSLog(@"block 新增方法回调值 %@",str);
    };
    ((void(*)(id,SEL,NSString *,CustomEvent)) objc_msgSend)(NSClassFromString(@"DHBlockCallbackViewController"),NSSelectorFromString(@"loadDetailCallBack:callBack:"),@"名字",finishCall);
    
    NSArray *a = @[@"https://rgslb.rtc.aliyuncs.com"];
    NSDictionary *dictInfo = @{
        @"userid":@"00009c29-df77-4402-87e1-8641cc0ce4ef",
        @"callid":@"0b5d5478-c1e3-43b1-b82f-26bbec451a05",
        @"appid":@"zz2skc04",
        @"sysappid":@"df336665-c22b-4270-b9ff-3f602f758e80",
        @"channelid":@"d4a6b288-1230-4b4a-a62b-c368eb16440c",
        @"nonce":@"CK-7b6ae612898396e8c25b3ecf0d1b424d",
        @"timestamp":@"1561691423",
        @"token":@"259c262ca1b8e967c91e2f07658074b79d416ddf89ad0cbf8ca408762ce14474",
        @"calltype":@"0",
        @"gslb":a,
        @"turn":@{@"username":@"测试5",@"adminid":@"00009c29-df77-4402-87e1-8641cc0ce4ef",@"adminame":@"张三",@"adminphoto":@"1",@"photo":@"1",@"password":@"444"},
        @"Total":@0,
        @"Ret":[NSNumber numberWithBool:true],
        @"Msg":@"获取成功",
        @"Obj":@"200"
    };
    
    ((void(*)(id,SEL,NSDictionary*))objc_msgSend)(viewController, NSSelectorFromString(@"setCommunicationMessage:"),dictInfo);
    /**
     [NSArray copy] 浅拷贝 还是那个对象
     [NSArray mutableCopy] 深拷贝 得到NSMutableArray
     [NSMutableArray copy] 深拷贝 得到 NSArray
     [NSMutableArray mutableCopy] 深拷贝 得到 NSMutableArray
     */
    
    
    /**
     1.type定义参考:https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
     2."v@:@",解释v-返回值void类型,@-self指针id类型,:-SEL指针SEL类型,@-函数第一个参数为id类型
     3."@@:",解释@-返回值id类型,@-self指针id类型,:-SEL指针SEL类型,
     d.注册到运行时环境
     objc_registerClassPair(kclass);
     e.实例化类
     id instance = [[kclass alloc] init];
     f.给变量赋值
     object_setInstanceVariable(instance, "expression", "1+1");
     g.获取变量值
     void * value = NULL;
     object_getInstanceVariable(instance, "expression", &value);
     h.调用函数
     [instance performSelector:@selector(getExpressionFormula)];
     */
    const char * className = "KYDog";
    Class kclass = objc_getClass(className);
    BOOL isSuccess = class_addIvar(kclass, "addVar", sizeof(NSString *), 0, "@");
    
    SEL selA = @selector(setExpressionFormula:);
    Method methodA = class_getInstanceMethod(kclass, selA);
    BOOL isSuccessMethod1 = class_addMethod(kclass, selA, method_getImplementation(methodA), method_getTypeEncoding(methodA));
    //等同于下面这行代码
    //    BOOL isSuccessMethod1 = class_addMethod(kclass, selA, (IMP)setExpressionFormula, "v@:@");
    SEL selB = @selector(getExpressionFormula);
    Method methodB = class_getInstanceMethod(kclass, @selector(getExpressionFormula));
    BOOL isSuccessMethod2 = class_addMethod(kclass, selB, class_getMethodImplementation(kclass, @selector(getExpressionFormula)), method_getTypeEncoding(methodB));
    
    isSuccessMethod1?NSLog(@"添加方法1成功"):NSLog(@"添加方法1失败");
    isSuccessMethod2?NSLog(@"添加方法2成功"):NSLog(@"添加方法2失败");
    isSuccess?NSLog(@"添加变量成功"):NSLog(@"添加变量失败");
    //    [person setValue:@"增加成了" forKey:@"addVar"];
    //    NSLog(@"addVar == %@",[person valueForKey:@"addVar"]);
    //    objc_allocateClassPair(kclass, className, 0);
    //    id per = [KYDog alloc];
    //    [per setValue:@"Lucy" forKey:@"namename"];
    //    NSLog(@"name == %@",[per valueForKey:@"namename"]);
    objc_registerClassPair(kclass);
    //    [person loadNameValue:@"name"];
    //    [person performSelector:@selector(loadNameValue:) withObject:@"minzhe"];
    //    SEL selector = NSSelectorFromString(@"loadNameValue:");
    //    IMP imp = [person methodForSelector:selector];
    //    void (*func)(id, SEL,NSString *) = (void *)imp;
    //    func(person, selector,@"namamam");
    
    Class XYClass = objc_allocateClassPair([NSObject class], "XYClass", 0);
    NSString*namename =@"namename";
    class_addIvar(XYClass, namename.UTF8String,sizeof(id),log2(sizeof(id)),@encode(id));
    objc_registerClassPair(XYClass);
    id p = [XYClass alloc];
    [p setValue:@"Lucy" forKey:@"namename"];
    NSLog(@"name == %@",[p valueForKey:@"namename"]);
    
    //对私有变量的更改
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(kclass, &count);
    Ivar namevar = ivars[1];
    object_setIvar(XYClass, namevar, @"456");
    NSString *privateName = object_getIvar(XYClass, namevar);
    NSLog(@"privateName : %@",privateName);
    NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(namevar)];
    ivarName = [ivarName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    ivarName = [ivarName stringByReplacingOccurrencesOfString:@"@" withString:@""];
    if ([ivarName containsString:@"privateName"]) {
        object_setIvar(XYClass, namevar, @"我的名字");
        NSString *privateName = object_getIvar(XYClass, namevar);
        NSLog(@"privateName %@",privateName);
    }
    
    id library = [[NSClassFromString(@"BlockObject") alloc] init];
    void(^DicBlock)(NSDictionary *dicdic) = ^(NSDictionary * inforDic){
        NSLog(@"dic %@",inforDic);
    };
    ((void(*)(id,SEL,id))objc_msgSend)([library class], NSSelectorFromString(@"numberInforDic:"), DicBlock);
    //上面这代码等同于下面
    id item = ((id(*)(id,SEL,NSDictionary *))objc_msgSend)(library, NSSelectorFromString(@"initWithProperty:"),@{@"kay":@"value"});
    NSLog(@"item %@",item);
    //随机生成一个名字
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    NSString    *uuidString = ( NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    NSLog(@"后台uuidString:%@",uuidString);
    
    [self.navigationController pushViewController:viewController animated:NO];
}
- (void(^)(NSString *str))occupation {
    return ^(NSString *str){//在此获取值
        NSLog(@"职业：%@",str);//在此重新赋值
    };
}
- (void)setExpressionFormula:(NSString *)string {
    NSLog(@"string %@--ClassName:%@",string,NSStringFromClass([self class]));
}
- (void)getExpressionFormula {
    NSLog(@"call getExpressionFormula");
}

- (void)test19 {
    CodeTime(^{
        //You code here...
        NSLog(@"--当前代码运执行时间--");
    });
    CGFloat timeFloat = 0.0 ;
    printf("begin:===========%lf\n",timeFloat);
    timeFloat = BNRTimeBlock(^{
        printf("end2:===========%lf\n",timeFloat);
    });
    printf("end1:===========%lf\n",timeFloat);
    
    double t = func_runtime(0, "");
    func_runtime(t, "end");
    NSLog(@"结果：%@",[self fuckyouWithUrl:@"热"]);

}

+ (NSString *)weatherState:(NSString *)s funcCallback:(BOOL(^)(NSDictionary *dict))finishCallBack{
    NSDictionary *dict = @{@"state":s};
    finishCallBack(dict);
    return dict[@"state"];
}
- (NSString *)fuckyouWithUrl:(NSString *)parm {
    NSString *restr = [DHBlockKnowledgePracticeViewController weatherState:parm funcCallback:^(NSDictionary *dict) {
        return [DHBlockKnowledgePracticeViewController resoult:dict];
    }];
    return restr;
}
+ (BOOL)resoult:(NSDictionary *)dict {
    if (dict) {
        return YES;
    }else{
        return NO;
    }
}
/*不使用 __weak, p = nil 后block块内打印出的对象仍不为空，说明block中都是对原对象的copy。
 
 使用 __weak p = nil 后person对象为nil ，说明block是对（原来指针的copy），也就是有两个不同的指针，指向同一个对象，对象释放后 weakObj 也不在持有， 并会被置nil 防止野指针报错。
*/
- (void)weakTest
{
    BlockObject *p = [[BlockObject alloc]init];
    p.name = @"myObject";

    NSLog(@"1---%@---%p--%@", p, &p,p.name);
    __weak BlockObject *weakObj = p;
    NSLog(@"2---%@---%p--%@", weakObj, &weakObj,weakObj.name);
   
    void(^testBlock)() = ^(){
          NSLog(@"3---%@---%p--%@", weakObj, &weakObj,weakObj.name);
//        NSLog(@"3---%@---%p--%@", p, &p,p.name);
    };
    
    testBlock();
    p = nil; // 这边值nil 用来判断block是否复制了对象
    testBlock();
}
/*
  ARC 环境下打印结果：(MRC 是没有__weak关键字的)
  //不使用 __weak
  1---<Person: 0x7fbf82505070>---0x7fff5ea9b828--myObject
  2---<Person: 0x7fbf82505070>---0x7fff5ea9b820--myObject
  3---<Person: 0x7fbf82505070>---0x7fbf82417330--myObject
  3---<Person: 0x7fbf82505070>---0x7fbf82417330--myObject

  //使用 __weak
  1---<Person: 0x7f87d3f0ca90>---0x7fff5811a828--myObject
  2---<Person: 0x7f87d3f0ca90>---0x7fff5811a820--myObject
  3---<Person: 0x7f87d3f0ca90>---0x7f87d3e0df30--myObject
  3---(null)---0x7f87d3e0df30--(null)
*/
- (void)test20 {
    //    [[CSPTimerMananger shareManager] start];
    //    [CSPTimerMananger shareManager].timeInterval = 10;
}
- (void)dealloc {
    NSLog(@"输出--%@",@"我被释放了");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
