//
//  DHGlobalConfig.m
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright ©https://github.com/miniLV/MNFloatBtn All rights reserved.
//
#import "DHGlobalContentButton.h"
#import "DHGlobalConfig.h"
#import "Unity.h"
//静态全局按钮
static DHGlobalConfig *_globalButton;
//静态环境变量标识
static NSString * _envstring;
static NSString * _HostURL ;

//static NSDictionary * _tmpDict;

CGFloat contentButtonW = 49;
CGFloat contentButtonH = 30;
CGFloat screenWidth = 0;
CGFloat screenHeight = 0;

@interface DHGlobalConfig(){
    //拖动按钮的起始坐标点
    CGPoint _touchPoint;
    //起始按钮的x,y值
    CGFloat _touchbuttonX;
    CGFloat _touchbuttonY;
}
//声明悬浮的按钮
@property (nonatomic, strong) DHGlobalContentButton *globalContentButton;
//@property (nonatomic, copy, class, readonly) NSDictionary *tmpDict;

//初始化全局按钮
+ (DHGlobalContentButton *)sharedInstanceButton;

@end

@implementation DHGlobalConfig

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat contentButtonX = 0;
        CGFloat contentButtonY = 60;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        frame = CGRectMake(contentButtonX, contentButtonY, 120, contentButtonH);
        self.frame = frame;
    }
    return self;
}

//初始化全局按钮
+ (DHGlobalConfig *)sharedInstanceButton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat contentButtonX = screenWidth - contentButtonW;
        CGFloat contentButtonY = 60;
        _globalButton = [[DHGlobalConfig alloc] initWithFrame:CGRectMake(contentButtonX, contentButtonY, contentButtonW, contentButtonH)];
        _globalButton.rootViewController = [[UIViewController alloc]init];
        [_globalButton showcontentButton];
    });
    [_globalButton show];
    return _globalButton;
}

- (void)show{
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    if (_globalButton.hidden) {
        _globalButton.hidden = NO;
    }
    else if (!_globalButton) {
        _globalButton = [[DHGlobalConfig alloc] initWithFrame:CGRectZero];
        _globalButton.rootViewController = [UIViewController new];
    }
    [_globalButton makeKeyAndVisible];
    _globalButton.windowLevel = UIWindowLevelStatusBar;
    [currentKeyWindow makeKeyWindow];
}

- (void)showcontentButton{
    self.globalContentButton.hidden = NO;
}

- (DHGlobalContentButton *)globalContentButton{
    if (!_globalContentButton) {
        _globalContentButton = [[DHGlobalContentButton alloc]init];
        //添加到window上
        [_globalButton addSubview:_globalContentButton];
        _globalContentButton.frame = _globalButton.bounds;
    }
    return _globalContentButton;
}


+ (void)setEnvironmentMap:(NSDictionary *)environmentMap
               currentEnv:(NSString *)currentEnv{
    if (currentEnv.length <= 0 || currentEnv == nil) {
        currentEnv = @"UAT";
    }
    //初始化按钮
    [self sharedInstanceButton];
    //设置环境变量
    [_globalButton.globalContentButton setEnvironmentMap:environmentMap currentEnvir:currentEnv];
    //重置环境
    _globalButton.globalContentButton.environmentMap = environmentMap;
    //获取当前环境
    _envstring = currentEnv;
    //环境配置
    _HostURL = DHGlobalConfig.HostURL;
}

- (void)changeEnv{
    //点击切换环境
    [self.globalContentButton changeEnvironment];
    //更新环境
    _HostURL = DHGlobalContentButton.HostURL;
    _envstring = DHGlobalContentButton.evnstring;
}

- (void)setMovingDirectionWithbuttonX:(CGFloat)buttonX buttonY:(CGFloat)buttonY{
    if (self.center.x >= screenWidth/2) {
        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠右自动吸边
            CGFloat buttonX = screenWidth - 10;
            self.frame = CGRectMake(buttonX, buttonY, 120, contentButtonH);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠左吸边
            CGFloat buttonX = 0;
            self.frame = CGRectMake(buttonX, buttonY, 120, contentButtonH);
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    //按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    _touchbuttonX = self.frame.origin.x;
    _touchbuttonY = self.frame.origin.y;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    //移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
    //默认都是有导航条的，有导航条的，父试图高度就要被导航条占据，固高度不够
    CGFloat defaultNaviHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + [Unity sharedInstance].getCurrentVC.navigationController.navigationBar.frame.size.height;
    //父试图的宽高
    CGFloat superViewWidth = screenWidth;
    CGFloat superViewHeight = screenHeight;
    CGFloat buttonX = self.frame.origin.x;
    CGFloat buttonY = self.frame.origin.y;
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;
    //x轴左右极限坐标
    if (buttonX > (superViewWidth-buttonW)){
        //按钮右侧越界
        CGFloat centerX = superViewWidth - buttonW/2;
        self.center = CGPointMake(centerX, centerY);
    }else if (buttonX < 0){
        //按钮左侧越界
        CGFloat centerX = buttonW * 0.5;
        self.center = CGPointMake(centerX, centerY);
    }
    //y轴上下极限坐标
    if (buttonY <= 0){
        //按钮顶部越界
        centerY = buttonH * 0.7;
        self.center = CGPointMake(centerX, centerY);
    }
    else if (buttonY > (superViewHeight-buttonH)){
        //按钮底部越界
        CGFloat y = superViewHeight - buttonH;
        self.center = CGPointMake(centerX, y);
    }else if(buttonY < defaultNaviHeight){
        CGFloat y = defaultNaviHeight*2;
        self.center = CGPointMake(centerX, y);
//        self.center = CGPointMake(buttonX, judgeSuperViewHeight);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGFloat buttonY = self.frame.origin.y;
    CGFloat buttonX = self.frame.origin.x;
    CGFloat minDistance = 2;
    //结束move的时候，计算移动的距离是>最低要求，如果没有，就调用按钮点击事件
    BOOL isOverX = fabs(buttonX - _touchbuttonX) > minDistance;
    BOOL isOverY = fabs(buttonY - _touchbuttonY) > minDistance;
    
    if (isOverX || isOverY) {
        //超过移动范围就不响应点击 - 只做移动操作
        [self touchesCancelled:touches withEvent:event];
    }else{
        [super touchesEnded:touches withEvent:event];
        if (_globalContentButton.buttonClick) {
            _globalContentButton.buttonClick(_globalContentButton);
        }else{
            [self changeEnv];
        }
    }
    //设置移动方法
    [self setMovingDirectionWithbuttonX:buttonX buttonY:buttonY];
}

#pragma mark - set、get方法
+(NSString *)HostURL{
    if (_HostURL == nil) {
        NSDictionary *tmpDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"DHGlobalConfigURL"];
        DHGlobalContentButton.HostURL = tmpDict[@"HostURL"];
        _HostURL = DHGlobalContentButton.HostURL;
        NSLog(@"%@",_HostURL);
    }
    return _HostURL;
}
+ (void)setHostURL:(NSString *)HostURL{
    _HostURL = HostURL;
}
+ (NSString *)envstring {
    if (_envstring == nil) {
        NSDictionary *tmpDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"DHGlobalConfigURL"];
        _envstring = tmpDict[@"TAG"];
    }
    return _envstring;
}
+ (void)setEnvstring:(NSString *)envstring{
    _envstring = envstring;
}
@end

