//
//  FullRootTabbarController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/31.
//

#import "FullRootTabbarController.h"
#import "FullBaseViewController.h"
#import "FullNavigationController.h"

@interface FullRootTabbarController ()

@end

@implementation FullRootTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBar];
}

- (void)createTabBar {
    
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"MainUI" withExtension:@"plist"];
    NSArray *sourceArray = [NSArray arrayWithContentsOfURL:plistUrl];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSDictionary *dic in sourceArray) {
        FullBaseViewController  *aVC = (FullBaseViewController *) [[NSClassFromString(dic[@"vcName"]) alloc]init];
        FullNavigationController *nav= [[FullNavigationController alloc]initWithRootViewController:aVC];
        UITabBarItem *tabItem = [[UITabBarItem alloc]initWithTitle:dic[@"title"] image:[[UIImage imageNamed:dic[@"icon"] ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:dic[@"selectIcon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        aVC.title = dic[@"title"];
        nav.tabBarItem = tabItem;
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
    self.tabBar.tintColor = [UIColor whiteColor];
}

- (BOOL)shouldAutorotate {
    
    FullNavigationController *nav = (FullNavigationController *)self.selectedViewController;
    if ([nav.visibleViewController isKindOfClass:[NSClassFromString(@"FullMessageViewController") class]]) {
        return YES;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    FullNavigationController *nav = (FullNavigationController *)self.selectedViewController;
    if ([nav.visibleViewController isKindOfClass:[NSClassFromString(@"FullMessageViewController") class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    FullNavigationController *nav = (FullNavigationController *)self.selectedViewController;
    if ([nav.visibleViewController isKindOfClass:[NSClassFromString(@"FullMessageViewController") class]]) {
        return UIInterfaceOrientationLandscapeLeft;
    }
    return UIInterfaceOrientationPortrait;
}
@end
