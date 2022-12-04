//
//  SceneDelegate.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "YKWoodpecker.h"


@interface SceneDelegate ()<CLLocationManagerDelegate,YKWCmdCoreCmdParseDelegate>
@property (nonatomic, strong) CLLocationManager *manager;//定位服务管理类

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    if (scene) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
//        self.window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        ViewController *homePageVC = [[ViewController alloc] init];
        //如果是故事板，window会自动生成并且关联到这个scene上
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    [self xxx];
//    [self initLocationManager];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    NSLog(@"场景已经断开连接");
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    NSLog(@"已经从后台进入前台");
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"即将从前台进入后台");
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"即将从后台进入前台");
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    NSLog(@"已经从前台进入后台");
}
- (void)xxx {
    // Release 下可开启安全模式，只支持打开安全插件 * 可选
//    #ifndef DEBUG
       [YKWoodpeckerManager sharedInstance].safePluginMode = YES;
//    #endif

       // 设置 parseDelegate，可通过 YKWCmdCoreCmdParseDelegate 协议实现自定义命令 * 可选
       [YKWoodpeckerManager sharedInstance].cmdCore.parseDelegate = self;
       
       // 显示啄幕鸟
       [[YKWoodpeckerManager sharedInstance] show];
       
       // 启动时可直接打开某一插件 * 可选
    //    [[YKWoodpeckerManager sharedInstance] openPluginNamed:@"xxx"];
}
- (void)initLocationManager {
    //1.创建定位管理对象
    _manager = [[CLLocationManager alloc]init];
    //2.设置属性 distanceFilter、desiredAccuracy
    _manager.distanceFilter = kCLDistanceFilterNone;//实时更新定位位置
    _manager.desiredAccuracy = kCLLocationAccuracyBest;//定位精确度
    if([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [_manager requestAlwaysAuthorization];
    }
    //该模式是抵抗程序在后台被杀，申明不能够被暂停
    _manager.pausesLocationUpdatesAutomatically = NO;
    _manager.allowsBackgroundLocationUpdates = YES;
    //3.设置代理
    _manager.delegate = self;
    //4.开始定位
    [_manager startUpdatingLocation];
    //5.获取朝向
    [_manager startUpdatingHeading];
}

// 定位成功调用的的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    // 获取位置信息
    CLLocation *newLocation=[locations lastObject];
    double lat = newLocation.coordinate.latitude;
    double lon = newLocation.coordinate.longitude;
    double alt = newLocation.altitude;
    NSLog(@"纬度:%f,经度:%f,海拔:%f",lat,lon,alt);
}

// 应用将要进入不活跃的状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self.manager startUpdatingLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"进入后台");
    UIApplication *app = [UIApplication sharedApplication];
    __block  UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgTask != UIBackgroundTaskInvalid){
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid){
            bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    
   [self.manager startUpdatingLocation];
}
@end
