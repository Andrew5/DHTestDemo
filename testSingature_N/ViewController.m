//
//  ViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#define SCREEN_WIDTH (IS_LANDSCAPE ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define UI(x) UIAdapter(x)
#define UIRect(x,y,width,height) UIRectAdapter(x,y,width,height)
#define yis 0.8
#define  GYScreen_W   [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "DHTool.h"

#import "DHCustomerAssertHandler.h"
#import "DHCustomAlertView.h"
#import "UIView+UIScreenDisplaying.h"
#import "LGTeacher.h"
#import "DHTestMessage.h"
#import "DHCustomeControl.h"
#import <DHTabBar/LZTabBarVC.h>
#import "DHSharedObject.h"
#import "testSingature_N-Swift.h"
#import "DHButton.h"
#import "CategoryRelyon/UIView+Extension.h"
#import <DHUIKitModule/DHUIKitModule-umbrella.h>
#import "DHNetworkSpeed.h"
#import "BNMarketModulesView.h"
#import "TestAControl.h"
#import "GeneralInterest.h"

#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#import <dlfcn.h>
#import <netinet/in.h>
#import <mach/mach.h>
#import <os/proc.h>

// pod install --verbose --no-repo-update //只安装新添加的库，已更新的库忽略
// pod update 类库名称 --verbose --no-repo-update // 只更新指定的库，其它库忽略

typedef NS_ENUM (NSUInteger,PAYType) {
    ///支付成功
    PAYTypeSuccess = 0,
    ///支付失败
    PAYTypeFail = 1,
    ///支付中
    PAYTypePaying = 2,
    ///支付取消
    PAYTypeCancel = 3,
    ///参数错误
    PAYTypeErrorparams = 5,
};
static NSString *PAYTypeStringMap[] = {
    [PAYTypeSuccess] = @"支付成功",
    [PAYTypeFail] = @"支付失败",
    [PAYTypePaying] = @"支付中",
    [PAYTypeCancel] = @"支付取消",
    [PAYTypeErrorparams] = @"参数错误"
};

#define PAYTypeString(num) (PAYType[num])

//    PAYTypeStringMap[PAYTypeErrorparams]
//元素的尺寸改变一个delta值
static inline CGFloat UIAdapter(CGFloat x) {
    CGFloat deltaX = 0;
    if (x > SCREEN_WIDTH) {
        deltaX = 2.0;
    } else if (x < SCREEN_WIDTH) {
        deltaX = -2.0;
    }
    return x + deltaX;
}
static inline CGRect UIRectAdapter(CGFloat x,CGFloat y,CGFloat width,CGFloat height) {
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

@interface ViewController ()<DHButtonDelegete,DHAlertViewDelegate>
@property (nonatomic, strong) DHCustomAlertView *alertViewCustom;
@property (nonatomic, copy) NSString *gmAnalyticsToken1;
//动画
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) UIView *towView;
@property (nonatomic, strong) CADisplayLink *displaylinkTimer;
//代理
@property (nonatomic,  strong) DHSharedObject *sharedObject;
// 测网速
@property (nonatomic,  strong) DHNetworkSpeed *speedMonitor;

@property (nonatomic,  strong) UIImageView *woodpeckerIcon;
@property (nonatomic,  strong) UIView *contentView;
@property (nonatomic,  strong) UIView *viewroot;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"首页";
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithOpaqueBackground];
            // 背景色
        appearance.backgroundColor = [UIColor whiteColor];
        // 去掉半透明效果
        appearance.backgroundEffect = nil;
        // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
        appearance.shadowColor = [UIColor clearColor];
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
    } else {
        // Fallback on earlier versions
    }
    NSString *u = @"adfas";
    if (!u) {
        NSLog(@"空");
    }
    [self test23];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.speedMonitor stopNetworkSpeedMonitor];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkDownloadSpeedNotificationKey object:nil];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@",[self.alertViewCustom isDisplayedInScreen] ? @"显示" : @"隐藏");

    CGPoint point = [[touches  anyObject] locationInView:self.view];
//    if ([self.alertViewCustom isDisplayedInScreen] == YES){
//        point = [self.alertViewCustom.layer convertPoint:point fromLayer:self.view.layer];
//        CALayer *layer = [self.alertViewCustom.layer hitTest:point];
//        if (layer == self.alertViewCustom.layer) {
//            [self.alertViewCustom close];
//        }else{
//            NSLog(@"touch other");
//        }
//    } else {
        point = [_woodpeckerIcon.layer convertPoint:point fromLayer:self.view.layer];
        if( [_woodpeckerIcon.layer containsPoint:point]){
    //        point = [_contentView.layer convertPoint:point fromLayer:_woodpeckerIcon.layer]; //get layer using containsPoint:
    //        if ([_contentView.layer containsPoint:point]) {
    //            NSLog(@"点击imageview");
    //        }
            if (_contentView.width == 0) {
                self->_contentView.width = 0100;
                self->_contentView.height = 100;
                _viewroot.width = 100.;
                _viewroot.height = 100.;
            }
//        }
    }
}

- (void)test1 {

    //    int a = 4;
    //    //第一个参数是条件,如果第一个参数不满足条件,就会记录和打印第二个参数
    //    NSAssert(a == 5, @"a must equal to 5");
    //只需要一个参数,如果参数存在程序继续运行,如果参数为空,则程序停止打印日志
    //    NSParameterAssert(a);
//    DHCustomerAssertHandler *myHandler = [[DHCustomerAssertHandler alloc] init];
//    //给当前的线程
//    [[[NSThread currentThread] threadDictionary] setValue:myHandler
//                                                   forKey:NSAssertionHandlerKey];
    /*
     1. instancesRespondToSelector只能写在类名后面，respondsToSelector可以写在类名和实例名后面。
     2. [类 instancesRespondToSelector]判断的是该类的实例是否包含某方法，等效于：[该类的实例 respondsToSelector]。
     3. [类 respondsToSelector]用于判断是否包含某个类方法。
     */
//    NSLog(@"UIScreen执行--%d",[UIScreen instancesRespondToSelector:@selector(currentMode)]);
    // 注册通知
    //    [[NSNotificationCenter defaultCenter] addObserverForName:@"block" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    //        NSLog(@"block方式受到系统通知");
    //    }];//首先点击发送通知，控制台会打印block方式受到系统通，然后点击注销通知，再点击发送通知，依然会打印
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFunc) name:@"block" object:nil];

    /*
     幂等有一下几种定义：
     对于单目运算，如果一个运算对于在范围内的所有的一个数多次进行该运算所得的结果和进行一次该运算所得的结果是一样的，那么我们就称该运算是幂等的。比如绝对值运算就是一个例子，在实数集中，有abs(a) = abs(abs(a))。
     对于双目运算，则要求当参与运算的两个值是等值的情况下，如果满足运算结果与参与运算的两个值相等，则称该运算幂等，如求两个数的最大值的函数，有在在实数集中幂等，即max(x,x) = x。
      */
}

- (void)test2 {
    self.alertViewCustom = [[DHCustomAlertView alloc]init];
    [self.alertViewCustom setContainerView:[self createView]];
    [self.alertViewCustom show];
    NSLog(@"%@",[self.alertViewCustom isDisplayedInScreen] ? @"显示" : @"隐藏");
}
- (UIView *)createView {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"增加白菜党等特色标签增加白菜党等特色标签增加白菜党等特色标签筛选";
    titleLabel.frame = CGRectMake(0, 10, 10 * 2 + 260, 40);
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260 + 10 * 2, 200)];
    [demoView addSubview:titleLabel];
    return demoView;
}

- (void)test3 {
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"----");
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒后重新获取验证码",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"--strTime:%@--",strTime);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)test4 {
    //学习全栈工程师文章
    //http://growth-in-action.phodal.com/#生成app
    //https://growth.phodal.com
    LGPerson *p = [[LGPerson alloc]init];
    [p eat];
    LGTeacher *t = [[LGTeacher alloc]init];
    [t eat];
    [t teach];
//    多态
    LGPerson *pp = [[LGTeacher alloc]init];
    [pp eat];
    LGTeacher *tt = [[LGPerson alloc]init];
    [tt eat];
}

- (void)test5 {
    DHTestMessage* hm = [DHTestMessage new];
    UILabel *time = [[UILabel alloc]init];
    time.frame = CGRectMake(0, 20, 100, 20);
    time.backgroundColor = [UIColor redColor];
    [self.view addSubview:time];
    hm.fragment      = @"/";
    hm.host          = @"www";
    hm.pathname      = @"eee";
    NSLog(@"-----");

    NSLog(@"%@",SD_PLT);
//    NSLog(@"%@",ABC);
}

- (void)test6 {
//    CGRect frame = CGRectMake(200, 200, 150, 150);
//    UIImageView *image1 = [[UIImageView alloc] initWithFrame:frame];
//    DHToolObject *tool = [[DHToolObject alloc]init];
//    NSArray<NSNumber *> *theColorValueArray = [tool getSamplePixelToImageBackGroundColor:[UIImage imageNamed:@"showmore"]];
//    image1.backgroundColor = [UIColor colorWithRed:[theColorValueArray[0] intValue]/255.0f green:[theColorValueArray[1] intValue]/255.0f blue:[theColorValueArray[2] intValue]/255.0f alpha:1];
//    [self.view addSubview:image1];
}

- (void)test7 {
    DHCustomeControl  *button = [[DHCustomeControl alloc]initWithFrame:CGRectMake(100, 100, 100, 100) centerInset:10 updownInset:10 imageName:@"showmore" labelString:@"测试" labelFont:18];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [self.view addSubview:button];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(touchAction) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)touchAction {
    
}

- (void)test8 {
    LZTabBarVC *tbc = [[LZTabBarVC alloc] init];
    [self addChildViewController:tbc];
    tbc.view.frame = self.view.frame;
    [self.view addSubview:tbc.view];
    //    [UIApplication sharedApplication].keyWindow.rootViewController = tbc;
    //    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

///TODO: block捕获
- (void)test9 {
    __block NSString *uwe ;
    void (^configureCell)(NSString*) = ^(NSString* model) {
        uwe = model;
    };
    configureCell(@"werwer");
    self.gmAnalyticsToken1 = uwe;
    NSLog(@"%@",self.gmAnalyticsToken1);
}

//实现多重代理
- (void)test10 {
    /*
     场景需求:某工具类需要持有多个代理对象，方便后续逐一回调。比如某个订阅器订阅了某个通知，然后通知到来时需要下发给每一个需要响应的页面，这些页面肯定是要实现订阅器的代理方法的。
     所以，遇到这种场景时，我们可能要注意了。不能使用常用数据类型来管理多个代理者了(因为代理者不能被强引用，会有循环引用问题),此时我们可以采用NSHashTable的弱引用特性。
     有这么个单例类：
     */
    self.sharedObject = [DHSharedObject shared];
    //    [self.sharedObject addDelegate:self];
    [self.sharedObject addDelegate:self dispathQueue:dispatch_get_main_queue()];
}
- (void)func {
    NSLog(@"---代理实现了----");
}

- (void)test11 {
    [self gradientViewMethod];
    
    _displaylinkTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    [_displaylinkTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)gradientViewMethod {
    CGFloat width = 70;//1225;
    UIImageView * image1 = [[UIImageView alloc]init];
    image1.contentMode = UIViewContentModeScaleAspectFill;
    [image1 setImage:[UIImage imageNamed:@"erweima"]];
    image1.frame = CGRectMake(0, 0, width, 70);
    UIImageView * image2= [[UIImageView alloc]init];
    image2.contentMode = UIViewContentModeScaleAspectFill;
    [image2 setImage:[UIImage imageNamed:@"QQ"]];
    image2.frame = CGRectMake(width, 0, width, 70);
    UIImageView * image3= [[UIImageView alloc]init];
    image3.contentMode = UIViewContentModeScaleAspectFill;
    [image3 setImage:[UIImage imageNamed:@"erweima"]];
    image3.frame = CGRectMake(width*2, 0, width, 70);
    UIImageView * image4= [[UIImageView alloc]init];
    image4.contentMode = UIViewContentModeScaleAspectFill;
    [image4 setImage:[UIImage imageNamed:@"copy"]];
    image4.frame = CGRectMake(width*3, 0,width, 70);
    UIImageView * image5= [[UIImageView alloc]init];
    image5.contentMode = UIViewContentModeScaleAspectFill;
    [image5 setImage:[UIImage imageNamed:@"QQ"]];
    image5.frame = CGRectMake(width*4, 0,width, 70);
    self.oneView = [[UIView alloc]init];
    self.oneView.backgroundColor = UIColor.grayColor;
    [self.oneView addSubview:image1];
    [self.oneView addSubview:image2];
    [self.oneView addSubview:image3];
    [self.oneView addSubview:image4];
    [self.oneView addSubview:image5];
    self.towView = [[UIView alloc]init];
    self.towView.backgroundColor = UIColor.darkGrayColor;
    [self.towView addSubview:image1];
    [self.towView addSubview:image2];
    [self.towView addSubview:image3];
    [self.towView addSubview:image4];
    [self.towView addSubview:image5];
    self.oneView.frame = CGRectMake(0, 0, width*5, 70);
    self.towView.frame = CGRectMake(0 - width*4, 0, width*5, 70);
    [self.view addSubview:self.oneView];
    [self.view addSubview:self.towView];
}
- (void)rotate {
    NSLog(@"%s-----%ld",__func__,_displaylinkTimer.preferredFramesPerSecond);
    self.oneView.frame =CGRectMake(self.oneView.frame.origin.x+yis,0, self.oneView.frame.size.width, 70);
    
    self.towView.frame = CGRectMake(self.towView.frame.origin.x+yis, 0, self.towView.frame.size.width, 70);
    
    if (self.oneView.frame.origin.x >GYScreen_W) {
        self.oneView.frame = CGRectMake(self.towView.frame.origin.x-self.oneView.frame.size.width, 0, self.oneView.frame.size.width, 70);
    }
    if (self.towView.frame.origin.x >GYScreen_W) {
        self.towView.frame = CGRectMake(self.oneView.frame.origin.x-self.towView.frame.size.width, 0, self.towView.frame.size.width, 70);
    }
}

- (void)test12 {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = UIColor.grayColor;
    view.frame = CGRectMake(100, 100, 100, 100);
    UIView *viewSuper = [[UIView alloc]init];
    viewSuper.backgroundColor = UIColor.redColor;
    viewSuper.frame = CGRectMake(25, 25, 50, 50);
    
// 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
// toView是view到viewSuper.superview 加convertPoint坐标点
    viewSuper.center = [view convertPoint:CGPointMake(viewSuper.center.x-10, viewSuper.center.y-10) toView:viewSuper.superview];
    
// 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
//    - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
// 将像素point从view中转换到当前视图中，返回在当前视图中的像素值（与toView相反）
//    - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
    
//    - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
    
//    - (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;

    [self.view addSubview:view];
    [view addSubview:viewSuper];
}
// 我其实今天都还挺开心的 我觉得是个没有压力 ，而且很和平的一个环境，而且我也真的在开会之前我一直都很开心，一直说到表演节目，我真的很不开心，就在刚刚的这个流程当中其实我是一个很敏感的人，我有一种强烈的被推着走的那种感受，所以我非常不喜欢这个感受，我觉得我必须说出来，因为我是觉得我们没法因为 就是布置的一个任务，我们一定要完成它而去完成它，我觉得我们每个人的情感都是在不断的越来越往上走的一个过程中，我更期待的是在我们，最后结局的时候， 我们真的是自然而然的发自内心的，比如说我有首歌我想唱或者我有个舞想跳，而不是提示(Q)XXX,让XXX干嘛，我不。

- (void)test13 {
    // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans"; // 简体中文
        } else { // zh-Hantzh-HKzh-TW
            language = @"zh-Hant"; // 繁體中文
        }
    } else {
        language = @"en";
    }
    //ibtool --errors --warnings --output-format human-readable-text --compile TPDoctorIntroductionView.nib TPDoctorIntroductionView.xib
}

- (void)test14 {
    // size不变 x = x+dx,y = y+dy,
//   CGRectOffset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>)
    NSArray *array = [NSArray arrayWithObjects:@"324",@"3241", nil];
    NSString *testString = array[2];
    NSLog(@"测试结果 %@",testString);
}
/// TODO: swift
- (void)test15 {
    
    // A(swift) push B(oc)
    // B input dismiss A
    // A block=^(string *dd){get string}
//    DHCustomerAlertViewListController *vc = [[DHCustomerAlertViewListController alloc]init];
    SetupViewController *vc = [[SetupViewController alloc]init];
    self.view.backgroundColor = UIColor.whiteColor;
    // 注意添加顺序
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 44*10);
}

//TODO: 自定义按钮、事件
- (void)test16 {

    DHButton *button = [[DHButton alloc]init];
    button.delegate = self;
    button.frame = CGRectMake(10, 100, 100, 30);
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    button.layer.borderWidth = 1.0;
    [self.view addSubview:button];
    //实现button的block回调
    [button setButtonShouldBlock:^BOOL(DHButton *sender) {
        NSLog(@"我是Block: should方法\n\n");
        return YES;
    }];
    [button setButtonWillBlock:^(DHButton *sender) {
        NSLog(@"我是Block: Will方法\n\n");
    }];
    [button setButtonDidBlock:^(DHButton *sender) {
        NSLog(@"我是Blcok: Did方法\n\n");
    }];
//  [button addTarget:self action:@selector(tapButton)];
}
- (void)tapButton{
    NSLog(@"OK");
}
// 实现button委托回调的方法myButtonShouldTap：设置button是否好用
//- (BOOL)myButtonShouldTap:(DHButton *)sender {
//    NSLog(@"我是Del啥egate：should方法");
//    return YES;
//}
// 实现按钮将要点击的方法
//- (void)myButtonWillTap:(DHButton *)sender {
//    NSLog(@"我是Delegate: will方法");
//}
// 实现按钮点击完要回调的方法
//- (void)myButtonDidTap:(DHButton *)sender {
//    NSLog(@"我是Delegate: Did");
//}

- (void)test17 {
    NSInvocationOperation * op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperationMethod:) object:@"1"];
    NSInvocationOperation * op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperationMethod:) object:@"2"];
    NSInvocationOperation * op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperationMethod:) object:@"3"];
    NSInvocationOperation * op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperationMethod:) object:@"4"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //    queue.maxConcurrentOperationCount = 1;//串行
    queue.maxConcurrentOperationCount = 2;//并发
    //    queue.maxConcurrentOperationCount = 0;//不执行任务
    //    queue.maxConcurrentOperationCount = -1;//特殊意义 最大值 表示不受限制
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
}
- (void)invocationOperationMethod:(NSString *)params {
    NSLog(@"--%@--%@",params,[NSThread currentThread]);
}

- (void)test18 {
    DHActionLinkLabel* p = [[DHActionLinkLabel alloc]initWithFrame:CGRectMake(40, 132, 100, 20)];
    p.backgroundColor = [UIColor clearColor];
    p.textAlignment   = NSTextAlignmentCenter;
    p.textColor       = [UIColor whiteColor];
    p.font = [UIFont systemFontOfSize:18.0];
    p.userInteractionEnabled = YES;
    p.didTouch = @selector(actionTitle:);
    p.delegate = self;
    p.changeAlpha = NO;
    [self.view addSubview:p];
}
- (void)actionTitle:(SEL)a {
    
}

- (void)test19 {
    __block int num = 0;
    dispatch_queue_t que = dispatch_get_global_queue(0, 0);
    for (int i = 0; i<10; i++) {
        dispatch_async(que, ^{
            num = i;
        });
    }
    NSLog(@"%d",num);
    
    
}

- (void)test20 {
    
    DHAlertView *alertView = [[DHAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    alertView.delegate = self;
    [alertView show];
}
- (void)alertView:(DHAlertView *)alertView didSelectedOptionButtonWithTag:(NSInteger)index {
    [alertView dismiss];
}

- (void)test21 {
    NSArray *arrTest = @[@{@"tagname":@"满足",@"tagtype":@"1"},@{@"tagname":@"等沙发上",@"tagtype":@"2"},@{@"tagname":@"满足啊的沙发上",@"tagtype":@"3"}];
 //   for (int i = 0; i < arrTest.count; i++) {
 //       NSLog(@"");
 //   }
 //   //参数为倒序遍历
 //   [arrTest enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 //        NSLog(@"%@",obj[@"tagtype"]);
 //    }];
 // 默认为正序遍历
    __block UILabel *label;
    [arrTest enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj[@"tagtype"]);
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.textColor = UIColor.redColor;
        tagLabel.backgroundColor = UIColor.blueColor;
        CGSize textSize = [obj[@"tagname"] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        if (idx == 0) {
            tagLabel.frame = CGRectMake(10+8, 45, 28 + 8, 16);
        } else {
            tagLabel.frame = CGRectMake(CGRectGetMaxX(label.frame) + 8, 45, textSize.width + 22, 16);
        }
        tagLabel.text = obj[@"tagname"];//[NSString stringWithFormat:@"%@",obj.tagName];
        label = tagLabel;
        [self.view addSubview:label];
    }];
//    //第一种，OC自带方法
//     //默认为正序遍历
//     [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//         NSLog(@"%ld,%@",idx,[arr objectAtIndex:idx]);
//     }];
//     //NSEnumerationReverse参数为倒序遍历
//     [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//         NSLog(@"%ld,%@",idx,[arr objectAtIndex:idx]);
//     }];
//
//     //第二种
//     dispatch_apply([arr count], dispatch_get_global_queue(0, 0), ^(size_t index){//并行
//         NSLog(@"%ld,%@",index,[arr objectAtIndex:index]);
//     });
//
//     //第三种
//     dispatch_apply([arr count], dispatch_get_main_queue(), ^(size_t index){//串行，容易引起主线程堵塞，可以另外开辟线程
//         NSLog(@"%ld,%@",index,[arr objectAtIndex:index]);
//     });
//
//     // 第四种，快速遍历
//     for (NSString * str in arr) {
//         NSLog(@"%@",str);
//     }
//
//     // 第五种，do-while
//     int i = 0;
//     do {
//         NSLog(@"%@",[arr objectAtIndex:i]);
//         i++;
//     } while (i<[arr count]);
//
//     // 第六种，while-do
//     int j = 0;
//     while (j<[arr count]) {
//         NSLog(@"%@",[arr objectAtIndex:j]);
//         j++;
//     }
//
//     // 第七种，普通for循环
//     for (int m = 0; m<[arr count]; m++) {
//         NSLog(@"%@",[arr objectAtIndex:m]);
//     }
//
//     // 第八种，迭代器
//     NSEnumerator *en = [arr objectEnumerator];
//     id obj;
//     NSInteger j = 0 ;
//     while (obj = [en nextObject]) {
//      NSLog(@"%ld,%@",j,obj);
//         j++;
//     }
    
}

- (void)test22 {
    
    self.speedMonitor = [[DHNetworkSpeed alloc]init];
    [self.speedMonitor startNetworkSpeedMonitor];
    [self.speedMonitor checkDeviceInfo];
    //监听下载速度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkSpeedChanged:) name:NetworkDownloadSpeedNotificationKey object:nil];
    //监听上传速度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkUploadSpeedChanged:) name:NetworkUploadSpeedNotificationKey object:nil];
}
//分别获取上行和下行的实时网速
- (void)networkUploadSpeedChanged:(NSNotification *)sender {
    
    NSString *uploadSpped = [sender.userInfo objectForKey:NetworkSpeedNotificationKey];
    NSLog(@"上传速度：%@",uploadSpped);
}
- (void)networkSpeedChanged:(NSNotification *)sender {
    
    NSString *downloadSpped = [sender.userInfo objectForKey:NetworkSpeedNotificationKey];
    NSLog(@"下载速度：%@",downloadSpped);
}

/// 各种绘制
- (void)test23 {
    BNMarketModulesView *iiii = [[BNMarketModulesView alloc]init];
    iiii.frame = CGRectMake(self.view.frame.size.width * 0.1, 150,self.view.frame.size.width * 0.8,self.view.frame.size.width * 0.8);
    iiii.layer.borderColor = [UIColor orangeColor].CGColor;
    iiii.layer.borderWidth = 1.0;
    [self.view addSubview:iiii];
}
- (void)test24 {
    TestAControl *ac = kGICOC(NSStringFromClass([TestAControl class]));
    NSLog(@"AC:%@",ac);
    ac.value = @"测试数据";
    NSString *value = ((TestAControl *)kGICOC(@"TestAControl")).value;
    NSLog(@"value:%@",value);
}
//TODO:  阶乘
long long dofactorial(int min, int max){
    if(min > max){
        return 0;
    }
    if(min == 0){
        if(max == 0){
            //0的阶乘是1
            return 1;
        }else{
            min = 1;
        }
        
    }
    long long result = 1;
    for (int i = min; i <= max; i++) {
        result *= i;
        
        if(result > INT_MAX){
            //考虑溢出
            return -1;
        }
    }
    return result;
}
//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
//    if (_woodpeckerIcon) {
//        CGPoint p = [_woodpeckerIcon convertPoint:point fromView:_viewroot];
//        if (CGRectContainsPoint(_woodpeckerIcon.bounds, p)) {
//            return YES;
//        }
//    }
//    return YES;
//}
// 动画
- (void)testView {

//    UIView *viewRed = [[UIView alloc]init];
//    [self.view addSubview:viewRed];
//    CGFloat x = 10;
//    CGFloat h = 200;
//    CGFloat y = ([UIScreen mainScreen].bounds.size.height - h)/2;
//    CGFloat w = [UIScreen mainScreen].bounds.size.width - x*2;
//    viewRed.frame = CGRectMake(x, y, w, h);
//    viewRed.backgroundColor = UIColor.redColor;
//
//    UIView *viewYellwo = [[UIView alloc]init];
//    [self.view addSubview:viewYellwo];
//    viewYellwo.frame = CGRectMake(10, 100, 100, 100);
//    viewYellwo.backgroundColor = UIColor.yellowColor;
//
//    UIView *viewBlack = [[UIView alloc]init];
//    [self.view addSubview:viewBlack];
//    viewBlack.backgroundColor = UIColor.blackColor;
//    CGFloat ww = (100)*[UIScreen mainScreen].bounds.size.height/750;
//    viewBlack.frame = CGRectMake(10, 100, ww, ww);
    
    
    _viewroot = [[UIView alloc]init];
    [self.view addSubview:_viewroot];
    _viewroot.frame = CGRectMake(10, 100, 100, 100);
    _viewroot.backgroundColor = UIColor.yellowColor;
    _viewroot.userInteractionEnabled = YES;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 200, 200)];
    _contentView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.9];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _contentView.clipsToBounds = YES;
    _contentView.layer.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _contentView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    _contentView.layer.cornerRadius = 2;
    [self.view addSubview:_contentView];
    
    
    UIImage *icon = [UIImage imageNamed:@"QQ"] ;//[UIImage imageNamed:@"QQ" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    if (icon) {
        _woodpeckerIcon = [[UIImageView alloc] initWithImage:icon];
        _woodpeckerIcon.layer.anchorPoint = CGPointMake(0.5, 0.9);//http://t.zoukankan.com/Free-Thinker-p-11269662.html哦
        
    } else {
        _woodpeckerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38., 38.)];
        _woodpeckerIcon.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
        _woodpeckerIcon.clipsToBounds = YES;
        _woodpeckerIcon.layer.anchorPoint = CGPointMake(0.7, 0.7);
        _woodpeckerIcon.layer.cornerRadius = 100 / 2.0;
    }
    _woodpeckerIcon.center = CGPointMake(12, 12);
    _woodpeckerIcon.userInteractionEnabled = YES;
    [_woodpeckerIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleIconTap:)]];
    [_viewroot addSubview:_woodpeckerIcon];
    
}
- (void)handleIconTap:(id)sender {
    if (_woodpeckerIcon.image) {
        [UIView animateWithDuration:0.06 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self->_woodpeckerIcon.transform = CGAffineTransformMakeRotation(M_PI_4 - 0.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 delay:0.05 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self->_woodpeckerIcon.transform = CGAffineTransformIdentity;
            } completion:nil];
        }];
    }
    
    if (_contentView.width > 10) {
        [self fold:YES];
    } else {
        [self unfold:YES];
    }
}
- (void)fold:(BOOL)animated {
    if (_contentView.width > 0) {
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                self->_contentView.width = 0;
                self->_contentView.height = 0;
            } completion:^(BOOL finished) {
                _viewroot.width = 1.;
                _viewroot.height = 1.;
            }];
        } else {
            _contentView.width = 0;
            _contentView.height = 0;
            _viewroot.width = 1.;
            _viewroot.height = 1.;
        }
    }
}
- (void)unfold:(BOOL)animated {
    if (_contentView.width <= 0) {
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                [self setupSize];
            }];
        } else {
            [self setupSize];
        }
    }
}
// Determine the size of the plugin collection view.
- (void)setupSize {
    NSInteger widthCount = 4;
    NSInteger heightCount = 0;
//    for (NSArray *pluginAry in _pluginModelArray) {
//        heightCount += (pluginAry.count + 3) / 4;
//    }
//    self.ykw_width = widthCount * ([YKWPluginModelCell cellSizeForModel:nil].width + 10) + 10;
//    self.ykw_height = heightCount * ([YKWPluginModelCell cellSizeForModel:nil].height + 10)  + _pluginModelArray.count * 20;
    if (_contentView.height > [UIScreen mainScreen].bounds.size.height * 3. / 4.) {
        _contentView.height = [UIScreen mainScreen].bounds.size.height * 3. / 4.;
    }
//    self.collectionView.frame = CGRectMake(0, 0, self.ykw_width, self.ykw_height);

    // Restore to previous postion on first show.
//    if (_firstLoad) {
//        _firstLoad = NO;
        NSString *centerStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"kYKWPluginsWindowLastCenter"];
        if (centerStr.length) {
            CGPoint center = CGPointFromString(centerStr);
            // Position protection.
            if (CGRectContainsPoint(UIEdgeInsetsInsetRect([UIApplication sharedApplication].keyWindow.bounds, UIEdgeInsetsMake(50, 50, 50, 50)), CGPointMake(center.x - _viewroot.width / 2., center.y - _viewroot.height / 2.))) {
                _viewroot.center = center;
            }
//        }
    }
    [self checkFrameOrigin];
}
- (void)checkFrameOrigin {
    if (!CGRectContainsPoint(UIEdgeInsetsInsetRect([UIScreen mainScreen].applicationFrame, UIEdgeInsetsMake(20, 20, 20, 20)), _viewroot.frame.origin)) {
        _viewroot.left = 20;
        _viewroot.top = 180;
    }
}

// 内存判断
- (void)foo {
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:10];
    while (1) {
        for (int i = 0; i < 10; i++) {
            UIImageView *vv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"erweima"]];
            [arr addObject:vv];
        }
        ViewController *vc= [[ViewController alloc]init];
        long aa = [ViewController footprintMemory];
        NSLog(@"%l",aa);
        [vc limitMemory];
    }
}

+ (long)footprintMemory {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (result != KERN_SUCCESS)
        return 0;
    return (long long)(vmInfo.phys_footprint);
}

- (long)limitMemory {
    if (@available(iOS 13.0, *)) {
        long availMem = os_proc_available_memory();
    }
    return 0;
}

// 为 layer 的动画设置不同的 anchor point，但是又不想改变 view 原来的 position，则需要做一些转换。
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    // 分别计算原来锚点和将更新的锚点对应的坐标点，这些坐标点是相对该 view 内部坐标系的。
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);

    // 如果当前 view 有做过 transform，这里要同步计算。
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);

    // position 是当前 view 的 anchor point 在其父 view 的位置。
    CGPoint position = view.layer.position;
    // anchor point 的改变会造成 position 的改变，从而影响 view 在其父 view 的位置，这里把这个位移给计算回来。
    position.x = position.x + newPoint.x - oldPoint.x;
    position.y = position.y + newPoint.y - oldPoint.y;

    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.layer.anchorPoint = anchorPoint; // 设置了新的 anchor point 会改变位置。
    view.layer.position = position; // 通过在 position 上做逆向偏移，把位置给移回来。
}

/// 镂空
- (CAGradientLayer *)searchViewAddGradientLayerWithSearchView:(UIView *)searchView andSearchBound:(CGRect)searchBound{
    /*
     1.CAGradientLayer的坐标系统是从坐标（0，0）到（1，1）绘制的矩形;
     2.CAGradientLayer的frame值的size不为正方形的话，坐标系统会被拉伸;
     3.CAGradientLayer的startPoint与endPoint会直接影响颜色的绘制方向;
     4.CAGradientLayer的颜色分割点是以0到1的比例来计算的;
     */
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = searchBound;
    gl.startPoint = CGPointMake(0,0);
    gl.endPoint = CGPointMake(1,1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:1.0 green:0.31 blue:0.39 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.97 green:0.17 blue:0.27 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 6;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.lineWidth = 1.0;
    UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:searchBound byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
    maskLayer.path = [path CGPath];
    maskLayer.fillColor = [[UIColor clearColor] CGColor];
    maskLayer.strokeColor = [[UIColor redColor] CGColor];
    gl.mask = maskLayer;
    [searchView.layer addSublayer:gl];
    return gl;
}
 @end
