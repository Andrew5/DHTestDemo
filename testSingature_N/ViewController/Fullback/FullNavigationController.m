//
//  FullNavigationController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import "FullNavigationController.h"
#import "UIViewController+DHFullCallBack.h"
#import "FullBaseViewController.h"
#import "FullBaseViewController.h"
#import "UIBarButtonItem+addition.h"

@interface FullNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation FullNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 处理全屏返回
    UIGestureRecognizer *systemGes = self.interactivePopGestureRecognizer;
    id target = systemGes.delegate;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.panGesture];
    self.panGesture.delegate = self;
    systemGes.enabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;//处理隐藏tabbar
        if ([viewController isKindOfClass:[FullBaseViewController class]]) {
            FullBaseViewController *vc = (FullBaseViewController *)viewController;
            // 给push的每个VC加返回按钮
            NSString *imageName = [vc backItemImageName];
            vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:imageName highIcon:@"" target:self action:@selector(back:)];
        } else {
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:@"" target:self action:@selector(back:)];
        }
    }
    [super pushViewController:viewController animated:animated];
    
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        // 修改tabBra的frame
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}

- (void)back:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    
    UIViewController *currentVC = self.topViewController;
    if (currentVC.callBackBlock) {
        currentVC.callBackBlock(sender);
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    if (self = [super initWithRootViewController:rootViewController]) {
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        NSDictionary *attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        self.navigationBar.titleTextAttributes = attributeDic;
        self.navigationBar.translucent = YES;
        [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UICollectionView")]) {
        UICollectionView *cv = (UICollectionView *)otherGestureRecognizer.delegate;
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)cv.collectionViewLayout;
        if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && cv.contentOffset.x > 0) {
                return NO;
            }else if(otherGestureRecognizer.state == UIGestureRecognizerStateBegan && cv.contentOffset.x <= 0){
                return YES;
            }
        } else {
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && cv.contentOffset.x > 0) {
                return YES;
            }else if(otherGestureRecognizer.state == UIGestureRecognizerStateBegan && cv.contentOffset.x <= 0){
                return NO;
            }
        }
        return YES;
    }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]){
        return YES;
    }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]){
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //解决与左滑手势冲突
    CGPoint translation = [self.panGesture translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    if (self.viewControllers.count > 1) {
        BOOL shouldBeginGesture = NO;
        if ([self.topViewController isKindOfClass:[FullBaseViewController class]]) {
            FullBaseViewController *currentVC = (FullBaseViewController *)self.topViewController;
            if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
                shouldBeginGesture = [currentVC gestureRecognizerShouldBegin];
                return shouldBeginGesture;
            }
        } else {
            return YES;
        }
    }
    return self.childViewControllers.count == 1 ? NO : YES;
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
