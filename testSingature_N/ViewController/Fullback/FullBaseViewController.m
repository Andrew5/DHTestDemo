//
//  FullBaseViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import "FullBaseViewController.h"

@interface FullBaseViewController ()

@end

@implementation FullBaseViewController

// 右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
  
    if (@available(ios 11.0,*)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            UITableView.appearance.estimatedRowHeight = 0;
            UITableView.appearance.estimatedSectionFooterHeight = 0;
            UITableView.appearance.estimatedSectionHeaderHeight = 0;
    } else {
        if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (NSString *)backItemImageName{
    return @"navigator_btn_back";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
