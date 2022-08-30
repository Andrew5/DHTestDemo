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

@interface ViewController ()<DHButtonDelegete>
@property (nonatomic, strong) DHCustomAlertView *alertViewCustom;
@property (nonatomic, copy) NSString *gmAnalyticsToken1;
//动画
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) UIView *towView;
@property (nonatomic, strong) CADisplayLink *displaylinkTimer;
//代理
@property (nonatomic,  strong) DHSharedObject *sharedObject;

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
    [self test15];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",[self.alertViewCustom isDisplayedInScreen] ? @"显示" : @"隐藏");

    [self.alertViewCustom close];
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
    NSLog(@"--%d",[UIScreen instancesRespondToSelector:@selector(currentMode)]);
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
    NSLog(@"-------");
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

- (void)test15 {
    
    // A(swift) push B(oc)
    // B input dismiss A
    // A block=^(string *dd){get string}
    SetupViewController *vc = [[SetupViewController alloc]init];
    self.view.backgroundColor = UIColor.whiteColor;
    // 注意添加顺序
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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

 @end
