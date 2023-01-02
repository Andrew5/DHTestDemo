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
#define GYScreen_W   [UIScreen mainScreen].bounds.size.width
#define KEY_PATH(objc, property) ((void)objc.property, @(#property))

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#import <dlfcn.h>
#import <netinet/in.h>
#import <mach/mach.h>
#import <os/proc.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>

#import "testSingature_N-Swift.h"

#import <DHTabBar/LZTabBarVC.h>
#import <YYKit/YYLabel.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <MBProgressHUD.h>
#import <DHUIKitModule/DHUIKitModule-umbrella.h>

#import "UIColor+KGExtension.h"
#import "LYDefineFoundation.h"
#import "UIImage+compressIMG.h"
#import "UILabel+LhGray.h"
#import "UIColor+LhGray.h"
#import "DHTJumpControllerTool.h"
#import "UIButton+ParamObject.h"
#import "UIView+UIScreenDisplaying.h"
#import "NSAttributedString+YYText.h"
#import "NSDate+LYDate.h"

#import "ViewController.h"
#import "DHCustomerAssertHandler.h"
#import "DHCustomAlertView.h"
#import "GLPageScrollView.h"
#import "GLRollingScrollview.h"
#import "DHCustomeControl.h"
#import "DHSharedObject.h"
#import "KSGuideManager.h"
#import "DHTestMessage.h"
#import "LGTeacher.h"
#import "KSGuideManager.h"
#import "DHButton.h"
#import "DHTool.h"
#import "Masonry.h"
#import "TestAControl.h"
#import "DHNetworkSpeed.h"
#import "GeneralInterest.h"
#import "PGDatePickManager.h"
#import "JKCicularProgressBar.h"
#import "BNMarketModulesView.h"
#import "YDYClaimGoalCustomerRequestInfoManageVCViewController.h"
#import "SWRevealViewController.h"
#import "LeftViewController.h"
#import "BaseAnimationController.h"
#import "RightViewController.h"
#import "UICalViewController.h"
#import "OCBarrageViewController.h"
#import "articleViewController.h"
#import "DHProgress.h"
#import "SampleManager.h"
#import "FlipViewController.h"
#import "YBUnlimitedSlideViewController.h"
#import "AppStoreStyleViewController.h"
#import "JYRadarChartViewController.h"
#import "SlideNavigationController.h"
#import "MenuViewController.h"
#import "GraphView.h"
#import "FullAddMainViewController.h"
#import "YGGravity.h"
#import "YGGravityImageView.h"
#import "ZEDSoundTool.h"
#import "YYFPSLabel.h"
#import "CocoaPicker-umbrella.h"
#import "Character.h"
#import "SwordStrategy.h"
#import "FistStrategy.h"
#import "GunStrategy.h"
#import "JYBLoading.h"
#import "PipViewController.h"

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
CGFloat XWScreenWidthRatio(){
    static CGFloat ratio;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ratio = [UIScreen mainScreen].bounds.size.width / 375.0f;
    });
    return ratio;
}

#define widthRatio(_f_) (_f_) * XWScreenWidthRatio()

static inline CGSize XWSizeMake(CGFloat width, CGFloat height){
    CGSize size; size.width = widthRatio(width); size.height = widthRatio(height); return size;
}

static inline CGPoint XWPointMake(CGFloat x, CGFloat y){
    CGPoint point; point.x = widthRatio(x); point.y = widthRatio(y); return point;
}

static inline CGRect XWRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    CGRect rect;
    rect.origin.x = widthRatio(x); rect.origin.y = widthRatio(y);
    rect.size.width = widthRatio(width); rect.size.height = widthRatio(height);
    return rect;
}

@interface ViewController ()<DHButtonDelegete,DHAlertViewDelegate,PGDatePickerDelegate,UITextFieldDelegate,JKCicularProgressBarDelegate,YBUnlimitedSlideViewControllerDelegate,GraphViewDelegate>
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
// 文字转图片展示
@property (strong, nonatomic) YYLabel *titleLabel;

// 输入框动效
@property (nonatomic ,strong) UITextField *searchView;
@property (nonatomic,   weak) CAGradientLayer *gl;

// test30
@property (strong, nonatomic) UIImageView   *backImageView;
@property (strong, nonatomic) UIImageView   *frontImageView;
@property (strong, nonatomic) UIView        *sliderView;

// test32
@property (strong, nonatomic)   iQiYiPlayButton *iQiYiPlayButton;
@property (strong, nonatomic)   YouKuPlayButton *youKuPlayButton;

@property (nonatomic, strong) YBUnlimitedSlideViewController *unlimitedSlideVC;

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) MASConstraint *rightConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"首页";//siriKit吗？还是shortcuts?
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
    //    NSLog(@"%@",[self getIPAddresses]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YYFPSLabel xw_addFPSLableOnWidnow];
    });
    
    //    [MasonryAutoViewController d_release];
    [self test25];
    
    NSLog(@"属性 %@",KEY_PATH(self,alertViewCustom));
}

- (void)XXXXXX {//}:(NSString *)first SecondParameter:(NSString *)second{
    //    NSLog(@"first %@--%@",first,second);
    [_rightConstraint activate];
}

- (void)targetBtnClicked:(UIButton*)sender {
    
    NSLog(@"我被点击了");
    NSLog(@"tag:%ld",(long)sender.tag);
    NSDictionary*info = sender.info;
    NSLog(@"%@",info);
    
    //告知需要更改约束
    //    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:3 animations:^{
        [sender mas_updateConstraints:^(MASConstraintMaker *make) {
            self.rightConstraint.mas_equalTo(-100);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.speedMonitor stopNetworkSpeedMonitor];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkDownloadSpeedNotificationKey object:nil];
}

//- (NSString *)getIPAddress:(BOOL)preferIPv4 {
//
//    NSArray *searchArray = preferIPv4 ?
//    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
//    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
//
//    NSDictionary *addresses = [self getIPAddresses];getIPAddresses
//    NSLog(@"addresses: %@", addresses);
//    __block NSString *address;
//    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL stop) {
//         address = addresses[key];
//         if(address) *stop = YES;
//     }];
//    return address ? address : @"0.0.0.0";
//}
//
//- (NSDictionary *)getIPAddresses {
//    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
//
//    // retrieve the current interfaces - returns 0 on success
//    struct ifaddrs *interfaces;
//    if(!getifaddrs(&interfaces)) {
//        // Loop through linked list of interfaces
//        struct ifaddrs *interface;
//        for(interface=interfaces; interface; interface=interface->ifa_next) {
//            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
//                continue; // deeply nested code harder to read
//            }
//            const struct sockaddr_in addr = (const struct sockaddr_in)interface->ifa_addr;
//            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
//                              // 协议族
//            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
//                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
//                NSString *type;
//                if(addr->sin_family == AF_INET) {
//                                          // intenet地址信息，详细内容之后讨论
//                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
//                        type = IP_ADDR_IPv4;
//                    }
//                } else {
//                    const struct sockaddr_in6 addr6 = (const struct sockaddr_in6)interface->ifa_addr;
//                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
//                        type = IP_ADDR_IPv6;
//                    }
//                }
//                if(type) {
//                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
//                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
//                }
//            }
//        }
//        // Free memory
//        freeifaddrs(interfaces);
//    }
//    return [addresses count] ? addresses : nil;
//}

// 获取子视图
- (void)getSub:(UIView *)view andLevel:(int)level {
    
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        NSLog(@"%@%d: %@", blank, level, subview.class);
        [self getSub:subview andLevel:(level+1)];
    }
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

- (void)loadManyDatas:(void(^)(NSString * infor))inforBlock; {
    for (int i = 0; i< 200; i++ ){
        NSLog(@"i am test performance");
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
    //    1、字符串的截取
    //1.截取字符串
    NSString *string1 =@"123456d890";
    NSString *str1 = [string1 substringToIndex:5];//截取掉下标5之前的字符串
    NSLog(@"截取的值为：%@",str1);
    NSString *str2 = [string1 substringFromIndex:3];//截取掉下标3之后的字符串
    NSLog(@"截取的值为：%@",str2);
    //    2、匹配字符串
    //    从字符串(sd是sfsfsAdfsdf)中查找(匹配)字符串(Ad)
    //2.匹配字符串
    NSString *string2 =@"sd是sfsfsAdfsdf";
    NSRange range = [string2 rangeOfString:@"Ad"];//匹配得到的下标
    NSLog(@"rang:%@",NSStringFromRange(range));
    string2 = [string2 substringWithRange:range];//截取范围内的字符串
    NSLog(@"截取的值为：%@",string2);
    //    3、字符串分割
    //    根据字符串中的某个字符(A)来分割字符串
    //3.分隔字符串
    NSString *string3 =@"sdfsfsfsAdfsdf";
    NSArray *array = [string3 componentsSeparatedByString:@"A"]; //从字符A中分隔成2个元素的数组
    NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
    
    UIButton*targetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        targetBtn.frame = CGRectMake(0, 100, 50,50);
    //        targetBtn.tag =100;
    [targetBtn setTitle:@"点我"forState:UIControlStateNormal];
    [targetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [targetBtn addTarget:self action:@selector(targetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [targetBtn setInfo:@{@"id":@"12138",@"name":@"target-action"}];
    [self.view addSubview:targetBtn];
    [targetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        _rightConstraint = make.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
    __block UIImage *testImage = [UIImage imageNamed:@"arrow"];
    //该方法返回的是UIImage类型的对象,即返回经该方法拉伸后的图像
    //传入的第一个参数capInsets是UIEdgeInsets类型的数据,即原始图像要被保护的区域
    //这个参数是一个结构体,定义如下
    //typedef struct { CGFloat top, left , bottom, right ; } UIEdgeInsets;
    //该参数的意思是被保护的区域到原始图像外轮廓的上部,左部,底部,右部的直线距离,参考图2.1
    //传入的第二个参数resizingMode是UIImageResizingMode类似的数据,即图像拉伸时选用的拉伸模式,
    //这个参数是一个枚举类型,有以下两种方式
    //UIImageResizingModeTile,     平铺
    //UIImageResizingModeStretch,  拉伸
    //横向区域：可拉伸区域大小为170-10(left)-10(right)=150，不可拉伸区域为左边界的10像素圆角和右边界的10像素圆角
    //UIEdgeInsets tileSets = {.left = 40, .top = 17, .right = 77, .bottom = 10};    UIEdgeInsets tileSets = {.left = 40, .top = 17, .right = 129, .bottom = 10};    UIEdgeInsets tileSets = {.left = 32, .top = 17, .right = 10, .bottom = 10};
    testImage = [testImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 17, 140, 10)resizingMode:UIImageResizingModeTile];
    //        testImage = [testImage resizableImageWithCapInsets:UIEdgeInsetsMake(100, 100, 0, 0)];
    
    UIImageView *testImageView = [[UIImageView alloc]initWithImage:testImage];
    [self.view addSubview:testImageView];
    [testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(testImage.size.width, testImage.size.height));
        _rightConstraint = make.right.mas_equalTo(self.view.mas_right).offset(-20);
        [_rightConstraint deactivate];
        
    }];
    [self performSelector:@selector(XXXXXX) withObject:nil afterDelay:1];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"0.1秒后获取frame：%@", scrollView);
    //        });
    //     [self performSelector:@selector(XXXXXX:SecondParameter:) withObject:@"firstParameter" withObject:@"secondParameter"];
    //    NSArray *objectArray = @[@{@"methodName":@"DynamicParameterString:",@"value":@"String"},@{@"methodName":@"DynamicParameterNumber:",@"value":@2}];
    //    for (NSDictionary *dic in objectArray) {
    //        [self performSelector:NSSelectorFromString([dic objectForKey:@"methodName"]) withObject:[dic objectForKey:@"value"]];
    //    }
    
    
    //    NSString *str = @"字符串";
    //    NSNumber *num = @20;
    //    NSArray *arr = @[@"数组值1", @"数组值2"];
    //    SEL sel = NSSelectorFromString(@"NSInvocationWithString:withNum:withArray:");
    //    NSArray *objs = [NSArray arrayWithObjects:str, num, arr, nil];
    //    [self performSelector:sel withObjects:objs];
    //    - (void)NSInvocationWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    //        NSLog(@"%@, %@, %@", string, number, array[0]);
    //    }
    
    //    NSString *str = @"字符串objc_msgSend";
    //    NSNumber *num = @20;
    //    NSArray *arr = @[@"数组值1", @"数组值2"];
    //    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:withNum:withArray:");
    //    ((void (*) (id, SEL, NSString *, NSNumber *, NSArray *)) objc_msgSend) (self, sel, str, num, arr);
    //    - (void)ObjcMsgSendWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    //        NSLog(@"%@, %@, %@", string, number, array[0]);
    //    }
    
    //    typedef struct ParameterStruct{
    //        int a;
    //        int b;
    //    }MyStruct;
    //    NSString *str = @"字符串 把结构体转换为对象";
    //    NSNumber *num = @20;
    //    NSArray *arr = @[@"数组值1", @"数组值2"];
    //    MyStruct mystruct = {10,20};
    //    NSValue *value = [NSValue valueWithBytes:&mystruct objCType:@encode(MyStruct)];
    //    SEL sel = NSSelectorFromString(@"NSInvocationWithString:withNum:withArray:withValue:");
    //    NSArray *objs = [NSArray arrayWithObjects:str, num, arr, value,nil];
    //    [self performSelector:sel withObjects:objs];
    //    - (void)NSInvocationWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array withValue:(NSValue *)value{
    //        MyStruct struceBack;
    //        [value getValue:&struceBack];
    //        NSLog(@"%@, %@, %@, %d", string, number, array[0],struceBack.a);
    //    }
    
    //    for(NSString *fontfamilyname in [UIFont familyNames]) {
    //        NSLog(@"family:'%@'",fontfamilyname);
    //        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname]) {
    //            NSLog(@"\tfont:'%@'",fontName);
    //        }
    //        NSLog(@"-------------");
    //    }
    
    //    NSString *resultStr = @"childSelectedBtn";
    //    if(resultStr && resultStr.length>0) {
    //        resultStr = [resultStr stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[resultStr substringToIndex:1] capitalizedString]];
    //        resultStr = [[@"set" stringByAppendingString:resultStr] stringByAppendingString:@":"];
    //    }
    //    NSLog(@"空%@",resultStr);
    
    //    NSString *u = @"adfas";
    //    if (!u) {
    //        NSLog(@"空");
    //    }
    /*
     + (NSString *)getIDFV
     {
      NSString *IDFV = (NSString *)[MYKeyChainTool load:@"IDFV"];
      
      if ([IDFV isEqualToString:@""] || !IDFV) {
      
       IDFV = [UIDevice currentDevice].identifierForVendor.UUIDString;
       [MYKeyChainTool save:@"IDFV" data:IDFV];
      }
      
      return IDFV;
     }
     // https://www.jianshu.com/p/40f2a026c41b
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
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260 + 10 * 2, 50)];
    [demoView addSubview:titleLabel];
    return demoView;
}

- (void)test3 {
    
    __block int timeout=90; //倒计时时间
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
    NSLog(@"%@",ABC);
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
    ///TODO: 策略模式
    // 创建一个人物
    Character *character = [[Character alloc] init];
    
    // 为人物选择一种攻击方式
    character.strategy = [[SwordStrategy alloc] init];
    
    // 人物攻击
    [character attack];
    
    // 为人物选择另一种攻击方式
    character.strategy = [[FistStrategy alloc] init];
    
    // 人物攻击
    [character attack];
    
    // 为人物选择另一种攻击方式
    character.strategy = [[GunStrategy alloc] init];
    
    // 人物攻击
    [character attack];
    
    //ibtool --errors --warnings --output-format human-readable-text --compile TPDoctorIntroductionView.nib TPDoctorIntroductionView.xib
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(90, 90, 200, 40)];
    [self.view addSubview:button];
    [button setTitle:@"呵呵哒" forState:UIControlStateNormal];
    NSLog(@"%@", button);
    NSLog(@"%@", button.titleLabel);
    
    [button layoutIfNeeded];
    NSLog(@"%@", button);
    NSLog(@"%@", button.titleLabel);
    
    JYBLoading *Loading = [[JYBLoading alloc]initWithView:self.view];
    Loading.plateOffset =  UIOffsetMake(0, -40);
    [self.view addSubview:Loading];
    Loading.type = JYBLoadingTypeLoadingTipsRoll ;
    
    [Loading show];
    
}

//TODO: 页面跳转
- (void)test14 {
    // size不变 x = x+dx,y = y+dy,
    //   CGRectOffset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>)
    //    NSArray *array = [NSArray arrayWithObjects:@"324",@"3241", nil];
    //    NSString *testString = array[2];
    //    NSLog(@"测试结果 %@",testString);
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    SEL medth = NSSelectorFromString(key);
    // 约定好的规则(只针对push做操作)
    NSDictionary *params = @{
        @"class" : @"YDYClaimGoalCustomerRequestInfoManageVC",
        @"property" : @{
            @"ID" : @"123",
            @"type" : @"dic"
        }
    };
    [DHTJumpControllerTool pushViewControllerWithParams:params];
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
- (void)tapButton {
    
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
    p.backgroundColor = [UIColor yellowColor];
    p.textAlignment   = NSTextAlignmentCenter;
    p.textColor       = [UIColor whiteColor];
    p.text = @"测绘测试";
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
    // 定义变量表示2023年有多少天双休日
    int weekendDays = 0;

    // 定义变量表示2023年每个月的天数
    int daysInMonths[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    // 循环遍历每个月的天数
    for (int i = 0; i < 12; i++) {
        // 当前月的天数
        int days = daysInMonths[i];
        
        // 循环遍历当前月的每一天
        for (int j = 1; j <= days; j++) {
            // 创建一个 NSCalendar 对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            // 创建一个 NSDateComponents 对象，表示2023年的第 i+1 个月的第 j 天
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.year = 2023;
            components.month = i + 1;
            components.day = j;
            
            // 使用 NSCalendar 对象的 dateFromComponents: 方法创建一个 NSDate 对象
            NSDate *date = [calendar dateFromComponents:components];
            
            // 使用 NSCalendar 对象的 component:fromDate: 方法获取 date 对应的星期几
            NSInteger weekDay = [calendar component:NSCalendarUnitWeekday fromDate:date];
            
            // 当星期六或星期天时，双休日天数加1
            if (weekDay == 7 || weekDay == 1) {
                weekendDays++;
            }
        }
    }

    // 输出结果
    NSLog(@"2023年一共有%d天双休日", weekendDays);
    
    
    
    // 首先定义一个数组，用来存储每月的天数
    NSArray *daysPerMonth = @[@31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31];

    // 定义变量存储结果
    int totalDaysOff = 0;

    // 循环遍历数组，计算每个月有多少周五和周六
    for (int i = 0; i < daysPerMonth.count; i++) {
        int daysInMonth = [daysPerMonth[i] intValue];
        // 计算当前月份第一个周五的日期
        int firstFriday = 5 - [[NSCalendar currentCalendar] firstWeekday] + 1;
        // 如果当前月份第一个周五是1号，说明上一个月的最后一天是周四，那么需要加上上一个月的最后一个周五和周六
        if (firstFriday == 1) {
            totalDaysOff += 2;
        }
        // 加上当前月份的周五和周六数量
        totalDaysOff += (daysInMonth - firstFriday + 1) / 7 * 2;
    }

    // 输出结果
    NSLog(@"Total days off in 2023: %d", totalDaysOff);


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

//TODO: 网络测速
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

- (void)test25 {
    PipViewController *controller = [[PipViewController alloc]init];
//    YDYClaimGoalCustomerRequestInfoManageVCViewController *controller = YDYClaimGoalCustomerRequestInfoManageVCViewController.alloc.init;
    [self.navigationController pushViewController:controller animated:YES];
    //    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    //    PGDatePicker *datePicker = datePickManager.datePicker;
    ////    datePicker.isOnlyHourFlag = YES;
    //    datePicker.delegate = self;
    //    datePicker.datePickerMode = PGDatePickerModeTime;
    //    [self presentViewController:datePickManager animated:false completion:nil];
}
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    
    NSLog(@"dateComponents = %@", dateComponents);
    //    [self.dayGameTimeButton setTitle:[NSString stringWithFormat:@"%ldh",dateComponents.hour] forState:(UIControlStateNormal)];
}

//TODO: 渐变色文字
- (YYLabel *)titleLabel {
    
    if (_titleLabel == nil) {
        YYLabel *label = [[YYLabel alloc] init];
        label.numberOfLines = 0;
        _titleLabel = label;
    }
    return _titleLabel;
}
- (void)test26 {
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(10);
        make.right.offset(-80);
        make.height.offset(40);
    }];
    //    UIColor *fillColor = [UIColor gradientColorWithSize:CGSizeMake(100, 40) direction:GradientColorDirectionLevel startColor:[UIColor redColor] endColor:[UIColor blackColor]];
    UIColor *fillColor = [UIColor redColor];
    
    //    CGSize size = CGSizeMake(100, MAXFLOAT);//设置高度宽度的最大限度
    //    CGRect rect = [label.text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil];
    NSString *string = @"自营";
    NSString *goodsNameString = [NSString stringWithFormat:@"%@  %@", string,@"Redmibook Pro 14 锐龙版全代Redmibook Pro 14 锐龙版全代Redmibook Pro 14 锐龙版全代锐龙版全代Redmibook Pro 14 锐龙版全代"];
    NSRange stringRange = [goodsNameString rangeOfString:string];
    NSMutableAttributedString *mutableAttrStr = [[NSMutableAttributedString alloc] initWithString:goodsNameString];
    [mutableAttrStr setLineBreakMode:NSLineBreakByWordWrapping range:NSMakeRange(0, goodsNameString.length)];
    [mutableAttrStr setLineSpacing:5 range:NSMakeRange(0, goodsNameString.length)];
    [mutableAttrStr setColor:[UIColor blackColor] range:NSMakeRange(0, goodsNameString.length)];
    [mutableAttrStr setFont:[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular] range:NSMakeRange(0, goodsNameString.length)];
    [mutableAttrStr setAlignment:NSTextAlignmentLeft range:NSMakeRange(0, goodsNameString.length)];
    [mutableAttrStr setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium] range:stringRange];
    [mutableAttrStr setColor:[UIColor whiteColor] range:stringRange];
    //[mutableAttrStr yy_setBackgroundColor:[UIColor redColor] range:stringRange];
    //YYTextBorder *border = [YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor redColor]];
    //字体边框
    YYTextBorder *border = [YYTextBorder borderWithFillColor:fillColor cornerRadius:2];
    //边框圆角
    border.cornerRadius = 4;
    border.insets = UIEdgeInsetsMake(-2, -4, -2, -4);
    [mutableAttrStr setTextBackgroundBorder:border range:stringRange];
    //显示text的容器
    YYTextContainer *textContainer = [YYTextContainer containerWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 140.0, 40)];
    textContainer.maximumNumberOfRows = 2;
    textContainer.insets = UIEdgeInsetsMake(0, 4, 0, 0);
    //textContainer.truncationType = YYTextTruncationTypeEnd; // 以省略号结尾
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:textContainer text:mutableAttrStr];
    self.titleLabel.textLayout = textLayout;
}

- (void)customeSearchView {
    
    self.searchView = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, CGRectGetWidth(self.view.frame) - 44 - 52, 32)];
    self.searchView.placeholder = @"请输入关键词";
    self.searchView.delegate = self;
    self.searchView.backgroundColor = [UIColor greenColor];
    self.searchView.layer.cornerRadius = 6;
    self.searchView.leftViewMode = UITextFieldViewModeAlways;
    self.searchView.rightViewMode = UITextFieldViewModeAlways;
    [self.searchView setTintColor:UIColor.grayColor];
    self.searchView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.searchView.textColor = UIColor.blackColor;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 32)];
    self.searchView.leftView = leftView;
    self.searchView.leftViewMode = 3;
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    self.gl = gl;
    gl.hidden = YES;
    gl.frame = self.searchView.bounds;
    gl.startPoint = CGPointMake(0,0);
    gl.endPoint = CGPointMake(1,1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:1.0 green:0.31 blue:0.39 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.97 green:0.17 blue:0.27 alpha:1.0].CGColor];
    gl.cornerRadius = 6;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.lineWidth = 1.0;
    UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:self.searchView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
    maskLayer.path = [path CGPath];
    maskLayer.fillColor = [[UIColor clearColor] CGColor];
    maskLayer.strokeColor = [[UIColor redColor] CGColor];
    gl.mask = maskLayer;
    [self.searchView.layer addSublayer:gl];
    [self.view addSubview:self.searchView];
}
//开始
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.gl.hidden = NO;
}
//结束编辑时触发
- (void)textFieldDidEndEditing:(UITextField*)textField {
    
    self.gl.hidden = YES;
    if (textField.text.length > 0) {
        //搜索有内容就插入历史记录列表
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)test27 {
    
    UITextField *view = [[UITextField alloc]init];
    [self.view addSubview:view];
    view.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 100, 100, 30);
    view.layer.borderColor = UIColor.redColor.CGColor;
    view.layer.borderWidth = 1.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
- (void)keyboardWillHide:(NSNotification *)name {
    
    //    CGRect rect = [name.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //  执行动画
    CGFloat duration = [name.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = self.view.bounds;
    }];
}
- (void)keyboardWillShow:(NSNotification *)name {
    
    CGRect rect = [name.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.view.frame = CGRectMake(0,-rect.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
}

// 版本更新
- (void)test28 {
    
    //First 服务器
    //Second 当前
    NSString *currectVersion = @"1.3.5";
    NSString *serverVersion = @"1.3.4";
    if ( [self versionCompareFirst:serverVersion andVersionSecond:currectVersion] ){
        NSLog(@"更新");
        NSLog(@"输出--%@", @"更新");
    }else {
        NSLog(@"不更新");
        NSLog(@"输出--%@", @"不更新");
    }
}
- (BOOL)versionCompareFirst:(NSString *)first andVersionSecond:(NSString *)second {
    
    NSArray *firstArray = [first componentsSeparatedByString:@"."];
    NSArray *secondArray = [second componentsSeparatedByString:@"."];
    NSInteger a = (firstArray.count > secondArray.count) ? secondArray.count : firstArray.count;
    for (int i = 0; i < a; i++) {
        NSInteger a = [[firstArray objectAtIndex:i] integerValue];
        NSInteger b = [[secondArray objectAtIndex:i] integerValue];
        if (a > b) {
            return YES;
        }else if (a < b) {
            return NO;
        }
    }
    return NO;
}
- (BOOL)hasNewVersion {
    NSString *updateVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"UpdateVersion"];
    if ([self versionCompareFirst:updateVersion andVersionSecond:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] == 1) {
        return YES;
    }
    return NO;
}
- (NSAttributedString *)attributedStringForVersionUpdate {
    NSString *upgradeText = @"更新版本";
    NSString * detailText = [NSString stringWithFormat:@"%@  %@", [self currentAppVersion], upgradeText];
    NSAttributedString *attributedStr = [self attributedStringWithText:detailText font:[UIFont fontWithName:@"PingFangSC-Regular" size:24/2] color:UIColor.redColor];
    NSMutableAttributedString *tmpAttributedStr = [attributedStr mutableCopy];
    [tmpAttributedStr addAttributes:@{NSForegroundColorAttributeName:UIColor.grayColor} range:NSMakeRange(detailText.length - upgradeText.length, upgradeText.length)];
    return [tmpAttributedStr copy];
}
- (NSAttributedString *) attributedStringWithText:(NSString *)title font:(UIFont *)font color:(UIColor*)color {
    return [[NSAttributedString alloc] initWithString:title attributes:@{
        NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:24/2],
        NSForegroundColorAttributeName:color ? : UIColor.redColor,
    }];
}
- (NSString *)currentAppVersion {
    NSDictionary *infoDictonary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [NSString stringWithFormat:@"%@",[infoDictonary objectForKey:@"CFBundleShortVersionString"]];
    //    NSString *version = [NSString stringWithFormat:@"%@(%@)",[infoDictonary objectForKey:@"CFBundleShortVersionString"],infoDictonary[@"CFBundleVersion"]];
    return  version;
}

- (void)test29 {
    UIImageView *view1 = [[UIImageView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"标签"];
    NSString *content = @"啊多少两个和不带券的两个 都给我切一下吧 带券 和不带券的少分";
    content = content.length > 30 ? [content substringToIndex:30] : content;//超过8个字符只取前8个字符
    CGSize size = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} context:nil].size;
    float headW = 16;
    float footW = 6;
    float space = 2;
    //leftCapWidth ,是左侧需要保留的像素数，topCapHeight是顶部需要保留的像素数
    //leftCapWidth: 左边不拉伸的像素
    //topCapHeight:上边不拉伸的像素
    image = [image stretchableImageWithLeftCapWidth:16 topCapHeight:0];
    view1.image = image;
    view1.frame = CGRectMake(0, 300, headW + footW + space + size.width, 32/2);
    [self.view addSubview:view1];
}

- (void)test30 {
    
    UIImageView *backImageView = [[UIImageView alloc]init];
    UIImageView *frontImageView = [[UIImageView alloc]init];
    UIView *sliderView = [[UIView alloc]init];
    
    [self.view addSubview:backImageView];
    [self.view addSubview:frontImageView];
    [self.view addSubview:sliderView];
    
    backImageView.frame = CGRectMake(0, 100, self.view.frame.size.width, 183);
    frontImageView.frame = CGRectMake(0, 100, self.view.frame.size.width, 183);
    sliderView.frame = CGRectMake((self.view.frame.size.width-4)/2, 100, 4, 183);
    
    backImageView.contentMode = 0;
    frontImageView.contentMode = 0;
    sliderView.backgroundColor = UIColor.yellowColor;
    
    [backImageView setImage:[UIImage imageNamed:@"test1"]];
    [frontImageView setImage:[UIImage imageNamed:@"test2"]];
    
    self.backImageView   =  backImageView;
    self.frontImageView  =  frontImageView;
    self.sliderView      =  sliderView;
    
    [self showBackImageWithCurrentX:backImageView.frame.origin.x + backImageView.frame.size.width * 0.5];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDidStart:)];
    [sliderView addGestureRecognizer:panRecognizer];
}
- (void)dragDidStart:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self.view];
    CGFloat currentX = point.x;
    if (currentX < self.backImageView.frame.origin.x) {
        currentX = self.backImageView.frame.origin.x;
    } else if (currentX > self.backImageView.frame.origin.x + self.backImageView.frame.size.width) {
        currentX = self.backImageView.frame.origin.x + self.backImageView.frame.size.width;
    }
    self.sliderView.frame = CGRectMake(currentX, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    [self showBackImageWithCurrentX:currentX];
}
- (void)showBackImageWithCurrentX:(CGFloat)currentX {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(currentX - self.backImageView.frame.origin.x, 0, self.backImageView.frame.origin.x + self.backImageView.frame.size.width - currentX, self.backImageView.frame.size.height)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.frontImageView.layer.mask = shapeLayer;
}

- (void)test31 {
    // 倒计时
    MZTLViewController *controller = MZTLViewController.alloc.init;
    [self addChildViewController:controller];
    controller.view.frame = self.view.frame;
    [self.view addSubview:controller.view];
}

- (void)test32 {
    /*
     ### 优酷播放按钮动画实现原理 [CSDN](http://blog.csdn.net/u013282507/article/details/77247437) / [简书](http://www.jianshu.com/p/32e7becf1a92)
     
     ### 爱奇艺播放按钮动画实现原理 [CSDN](http://blog.csdn.net/u013282507/article/details/77676294) / [简书](http://www.jianshu.com/p/3546964996ff)
     
     ### 个人开发过的UI工具集合 [XLUIKit](https://github.com/mengxianliang/XLUIKit)
     */
    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
    _iQiYiPlayButton = [[iQiYiPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:iQiYiPlayButtonStatePlay];
    _iQiYiPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3);
    [_iQiYiPlayButton addTarget:self action:@selector(iQiYiPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_iQiYiPlayButton];
    
    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
    _youKuPlayButton = [[YouKuPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:YouKuPlayButtonStatePlay];
    _youKuPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*2/3);
    [_youKuPlayButton addTarget:self action:@selector(youKuPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_youKuPlayButton];
}
- (void)iQiYiPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_iQiYiPlayButton.buttonState == iQiYiPlayButtonStatePause) {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePlay;
    }else {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePause;
    }
}
- (void)youKuPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_youKuPlayButton.buttonState == YouKuPlayButtonStatePause) {
        _youKuPlayButton.buttonState = YouKuPlayButtonStatePlay;
    }else {
        _youKuPlayButton.buttonState = YouKuPlayButtonStatePause;
    }
}

- (void)test33 {
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i =0; i < 6; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        [images addObject:image];
    }
    GLRollingScrollview *rollingScrollView = [GLRollingScrollview creatGLRollingScrollviewWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 200) imageArray:images timeInterval:2 didSelect:^(NSInteger atIndex) {
        NSLog(@" 打印信息:%ld",(long)atIndex);
    } didScroll:^(NSInteger toIndex) {
        
    }];
    [self.view addSubview:rollingScrollView];
    
    //    [XLBallLoading showInView:self.view];
    
    //    [[KSGuideManager shared] showGuideViewWithImages:images];
    
    //    GLPageScrollView *pageScrollView = [[GLPageScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 200)];
    //    [self.view addSubview:pageScrollView];
    //    NSMutableArray *images = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < 5; i++) {
    //        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg",i + 1]]];
    //    }
    //    NSArray *array = @[@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F8%2F549cf5201acb9.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668445049&t=36cfd28ac34a6f91e0d5c1e696c53c15",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2020-04-23%2F5ea162716a94c.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668445049&t=4ec34c4a8eef90aaad7f1cf935ab2815",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2020-09-23%2F5f6aa87085360.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668445049&t=22cf9952ee369b0046ef0417757f5d2a"];
    //
    //    [images addObjectsFromArray:array];
    //    pageScrollView.images = images;
    ////    [pageScrollView setTimeinterval:2];
    //    pageScrollView.didSelectIndexBlock = ^(NSInteger index) {
    //        NSLog(@" 打印信息 点击:%ld",(long)index);
    //    };
    //    pageScrollView.didScrollToIndexBlock = ^(NSInteger index) {
    //        NSLog(@" 打印信息 滚动:%ld",(long)index);
    //    };
}

// 镂空
- (void)test34 {
    
    UIImageView *viewCustom = [[UIImageView alloc]init];
    [self.view addSubview:viewCustom];
    viewCustom.image = [UIImage imageNamed:@"jiangzhe3"];
    viewCustom.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, [UIScreen mainScreen].bounds.size.height - 40);
    //    viewCustom.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    
    //    UILabel *titleLabel = [[UILabel alloc]init];
    //    titleLabel.font = [UIFont systemFontOfSize:18];
    //    titleLabel.textColor = [UIColor redColor];
    //    titleLabel.backgroundColor = [UIColor clearColor];
    //    titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    //    titleLabel.text = @"增加白菜";
    //    titleLabel.frame = CGRectMake(67, [UIScreen mainScreen].bounds.size.height - 240, 70,20);
    //    [self.view addSubview:titleLabel];
    
    
    
    //    CGRect rect = self.view.frame;
    //    CGFloat X = rect.origin.x;
    //    CGFloat Y = rect.origin.y;
    //    CGFloat W = 300;
    //    CGFloat H = 500;
    //
    //    UIView *backgroundView = [[UIView alloc] init];
    //    backgroundView.frame = self.view.bounds;
    //    backgroundView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:backgroundView];
    //    [backgroundView.layer addSublayer:[self createHollowOutView:backgroundView]];
    
    [self creatControlWithType:0];
}

- (void)test35 {
    JKCicularProgressBar *cicularProgressBar = [[JKCicularProgressBar alloc]initWithFrame:CGRectMake(300, 180, 120, 120)];
    cicularProgressBar.time = 60*2;
    cicularProgressBar.delegate = self;
    [self.view addSubview:cicularProgressBar];
    [cicularProgressBar start];
    [cicularProgressBar successful];
}

- (NSString *)ssid {
    NSString *ssid = @"o Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            ssid = [dict valueForKey:@"SSID"];
        }
    }
    return ssid;
}


- (void)test36 {
    //左侧菜单栏
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    
    //首页
    BaseAnimationController *centerView1Controller = [[BaseAnimationController alloc] init];
    
    //右侧菜单栏
    RightViewController *rightViewController = [[RightViewController alloc] init];
    
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:leftViewController frontViewController:centerView1Controller];
    revealViewController.rightViewController = rightViewController;
    
    //浮动层离左边距的宽度
    revealViewController.rearViewRevealWidth = 230;
    //    revealViewController.rightViewRevealWidth = 230;
    
    //是否让浮动层弹回原位
    //revealViewController.bounceBackOnOverdraw = NO;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
    [self addChildViewController:revealViewController];
    [self.view addSubview:revealViewController.view];
    [revealViewController didMoveToParentViewController:self];
    
}

- (void)test37 {
    UICalViewController *urightViewController = [[UICalViewController alloc] init];
    [self addChildViewController:urightViewController];
    [self.view addSubview:urightViewController.view];
    [urightViewController didMoveToParentViewController:self];
}

- (void)test38 {
    OCBarrageViewController *controller = OCBarrageViewController.alloc.init;
    [self.navigationController pushViewController:controller animated:YES];
}

//FIXME: 修改
- (void)test39 {
    articleViewController *controller = articleViewController.alloc.init;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)test40 {
    DHProgress *progressView = [[DHProgress alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:progressView];
    float value = arc4random()%+100;
    [progressView progress:value];
}
- (void)test41 {
    SampleStudent *_student = [[SampleStudent alloc] init];
    _student.name = @"xiaohao";
    _student.age = @"20";
    _student.image = @"imagePath";
    [[SampleManager instance] createSampleStudentTable];
    [[SampleManager instance] insertStudent:_student];
    NSLog(@"%@",[[SampleManager instance] allStudent]);
}
- (void)test42 {
    FlipViewController *flip = [[FlipViewController alloc]initWithNibName:@"FlipViewController" bundle:nil];
    [self.navigationController pushViewController:flip animated:YES];
}

- (void)test43 {
    
    _unlimitedSlideVC = [[YBUnlimitedSlideViewController alloc]init];
    //如果想添加pageControl,就将其置为YES,不需要的可以不写,或者置为NO
    _unlimitedSlideVC.isPageControl = YES;
    _unlimitedSlideVC.delegate = self;
    //设置子控制器view的frame
    _unlimitedSlideVC.view.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*9/16);
    [self addChildViewController:_unlimitedSlideVC];
    [self.view addSubview:_unlimitedSlideVC.view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
    [_unlimitedSlideVC.view addGestureRecognizer:tap];
}
- (void)handleTapAction:(UITapGestureRecognizer *)sender{
    
    NSLog(@"当前点击了第 %ld 张图片",[_unlimitedSlideVC backCurrentCilkPicture]);
}
//必须实现的方法,返回要展示的图片数组
- (NSMutableArray *)backDataSourceArray{
    NSArray *array = @[@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg"];
    return [NSMutableArray arrayWithArray:array];
}
////如果不实现,ScrollerView的默认宽是屏幕的宽,高是宽的0.5625倍
//- (CGSize)backScrollerViewForWidthAndHeight{
//
//    return CGSizeMake(320, 180);
//}

// 实现苹果商店 tableview横向滑动效果
- (void)test44 {
    AppStoreStyleViewController *controller = AppStoreStyleViewController.alloc.init;
    [self.navigationController pushViewController:controller animated:YES];
}

// 状图
- (void)test45 {
    JYRadarChartViewController *controller = JYRadarChartViewController.alloc.init;
    [self.navigationController pushViewController:controller animated:YES];
}
//FIXME: 修改
- (void)test46 {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *controller = [mainStoryboard instantiateInitialViewController];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    self.view.opaque = 0;
    MenuViewController *rightMenu = (MenuViewController*)[mainStoryboard
                                                          instantiateViewControllerWithIdentifier: @"MenuViewController"];
    rightMenu.view.backgroundColor = [UIColor yellowColor];
    rightMenu.cellIdentifier = @"rightMenuCell";
    MenuViewController *leftMenu = (MenuViewController*)[mainStoryboard
                                                         instantiateViewControllerWithIdentifier: @"MenuViewController"];
    leftMenu.view.backgroundColor = [UIColor lightGrayColor];
    leftMenu.cellIdentifier = @"leftMenuCell";
    [SlideNavigationController sharedInstance].righMenu = rightMenu;
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    
}

- (void)test47 {
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.label.text = NSLocalizedString(@"Loading graph data...", @"");
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970: 1351036800];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970: 1382096000];
    NSArray *graphObjects = [NSArray arrayWithArray: [GraphDataObject randomGraphDataObjectsArray:2000 startDate:startDate endDate:endDate]];
    GraphView *graphView = [[GraphView alloc]initWithFrame:DEFAULT_GRAPH_VIEW_FRAME objectsArray:graphObjects startDate:startDate endDate:endDate delegate:self];
    [self.view addSubview:graphView];
}
#pragma mark GraphViewDelegate
- (void)graphViewDidUpdate:(GraphView *)view{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
}
- (void)graphViewWillUpdate:(GraphView *)view{
    if(!self.hud){
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text =  NSLocalizedString(@"Loading graph data...", @"");
    }
}

- (void)test48 {
    YGGravityImageView *imageView = [[YGGravityImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    imageView.image = [UIImage imageNamed:@"login_bg6.png"];
    [self.view addSubview:imageView];
    [imageView startAnimate];
    
    [[ZEDSoundTool sharedSoundTool] playSoundWithName:@"ring.caf"];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *myBundlePath = [mainBundle pathForResource:@"base64" ofType:@"txt"];
    
    NSData *imageData = [[NSData alloc]initWithBase64EncodedString:myBundlePath options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.image = [UIImage imageWithData:imageData];
    [self.view addSubview:view];
    
    FullAddMainViewController  *controller = FullAddMainViewController.alloc.init;
    [self.navigationController pushViewController:controller animated:YES];
    //[PHAssetChangeRequest deleteAssets:@[Asset]]API来完成对照片的删除功能
}

- (void)test49 {
    // 来判断是否支持换应用图标
    if ([UIApplication sharedApplication].supportsAlternateIcons) {
        [[UIApplication sharedApplication] setAlternateIconName:@"notepad" completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"更换app图标发生错误了 ： %@",error);
            } else {
                NSLog(@"更换app图标成功");
            }
        }];
    }
}
- (void)test50 {
    CocoaPickerViewController *transparentView = [[CocoaPickerViewController alloc] init];
    transparentView.delegate = self;
    transparentView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    transparentView.view.frame=self.view.frame;
    transparentView.view.superview.backgroundColor = [UIColor clearColor];
    [self presentViewController:transparentView animated:YES completion:nil];
}
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)liziAnimation {
    
    CAKeyframeAnimation * anim =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.values = @[@1.5,@.8,@1,@1.2,@1];
    anim.duration = .6;
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    
    emitterLayer.beginTime = CACurrentMediaTime();//同一时间出发
    emitterLayer.birthRate = 1;        anim.values = @[@.8,@1.0];
    anim.duration = .4;
    //CAEmitterCell 相当于粒子动画中的一个粒子，比如烟花动画，cell就是每一朵烟花
    CAEmitterCell * cell =[[CAEmitterCell alloc]init];
    cell.name = @"explosionCell";//设置标识
    cell.lifetime = .7;//存活时间
    cell.birthRate = 4000;//数量，一秒钟产生4000个
    cell.velocity = 50; //初始化速度
    cell.velocityRange = 15;//速度范围
    cell.scale =.03;//缩小比例
    cell.scaleRange =.02;//比例范围
    cell.contents =(id)[UIImage imageNamed:@"test"].CGImage;//设置图片
    
    emitterLayer.name = @"explosionLayer";
    emitterLayer.emitterShape = kCAEmitterLayerCircle;//设置形状
    emitterLayer.emitterMode = kCAEmitterLayerOutline;//设置模式,从哪个位置发出，从发射器边缘发射
    emitterLayer.emitterSize = CGSizeMake(10, 10);//设置大小
    emitterLayer.emitterCells = @[cell];//可以设置多种cell
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;//渲染模式，越早的在上面
    emitterLayer.masksToBounds = NO;//为了防止它在边缘消失
    emitterLayer.birthRate = 0;//整个例子的数量
    emitterLayer.zPosition =0;//层级关系越小的在上面
    //           emitterLayer.position = CGPointMake(CGRectGetWidth(label_label.bounds)/2, CGRectGetHeight(label_label.bounds)/2);//设置位置
    //           [label_label.layer addSublayer:emitterLayer];
    //
    //       [label_label.layer addAnimation:anim forKey:nil];
}
- (void)addCAEmitteAnimation {
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = CGRectMake(10, 10, 10, 10);
    emitter.lifetime = 8;
    emitter.emitterSize = CGSizeMake(1,1);//设置大
    //    [label_label.layer addSublayer:emitter];
    
    emitter.emitterShape = kCAEmitterLayerCircle;
    emitter.emitterMode = kCAEmitterLayerSphere;
    emitter.emitterPosition = CGPointMake(30, 30);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"test"].CGImage;
    //产生粒子的个数
    cell.birthRate = 1.5;
    //粒子的生命周期
    cell.lifetime = 0.12;
    cell.lifetimeRange = 0.1;
    //粒子透明度变化
    cell.alphaSpeed = -0.4;
    // 4.3.缩放比例
    cell.scale = 0.3;
    cell.scaleRange = 0.1;
    //粒子速度
    cell.velocity = 110;
    cell.velocityRange = 50;
    //粒子发射方向
    cell.emissionLongitude = -M_PI_2;
    cell.emissionRange = M_PI_4;
    //旋转
    cell.spin = 0.1;
    cell.spin = 0.9;
    emitter.emitterCells = @[cell];
    
}

int maxSubArray(int* nums, int numsSize){
    if(numsSize==0) return 0;
    if(numsSize==1) return nums[0];
    int i=0,temp=0,maxValue=-1024;
    for(i=0;i<numsSize;i++)
    {
        temp=temp+nums[i];
        if(temp>maxValue) maxValue=temp;
        if(temp<0) temp=0;
    }
    return maxValue;
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
        CGRect frame = _viewroot.frame;
        frame.origin.x = 20;
        frame.origin.y = 180;
        _viewroot.frame = frame;
        //        _viewroot.left = 20;
        //        _viewroot.top = 180;
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

- (CAShapeLayer *)createHollowOutView:(UIView *)targetView {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:targetView.bounds];
    // 创建一个圆形path
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(targetView.center.x/2, targetView.center.y *3/2)radius:40 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    shapeLayer.opacity = 0.5;
    return shapeLayer;
}

//https://cloud.tencent.com/developer/article/1336361
- (void)creatControlWithType:(int)type {
    // 遮盖视图
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    //    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    bgView.backgroundColor = [UIColor whiteColor];
    
    //    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [self.view addSubview:bgView];
    // 信息提示视图
    UIImageView *imgView = [[UIImageView alloc] init];
    [bgView addSubview:imgView];
    
    // 第一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    switch (type) {
        case 0:
            // 下一个路径，圆形
            [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(227, 188) radius:46 startAngle:0 endAngle:2 * M_PI clockwise:NO]];
            imgView.frame = CGRectMake(220, 40, 100, 100);
            imgView.image = [UIImage imageNamed:@"copy"];
            break;
        case 1:
            // 下一个路径，矩形
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
            imgView.frame = CGRectMake(100, 320, 120, 120);
            imgView.image = [UIImage imageNamed:@"QQ"];
            break;
        default:
            break;
    }
    // 绘制透明区域
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
}

@end
