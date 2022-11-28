//
//  FullAddMainViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/31.
//

#import "FullAddMainViewController.h"
#import "FullUserGuideViewController.h"
#import "FullRootTabbarController.h"

@interface FullAddMainViewController ()

@end

@implementation FullAddMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRootVC];
}

- (void)loadRootVC {
    
    UIViewController *rootVC = UIViewController.new;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 如果是第一次启动,使用UserGuideViewController (用户引导页面) 作为根视图
        FullUserGuideViewController *rootTmpVC = [[FullUserGuideViewController alloc]init];
        rootVC = rootTmpVC;
    } else {
        FullRootTabbarController *rootTmpVC = [[FullRootTabbarController alloc]init];
        rootVC = rootTmpVC;
    }
    rootVC.modalPresentationStyle = 0;
    [self presentViewController:rootVC animated:YES completion:^{}];
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
