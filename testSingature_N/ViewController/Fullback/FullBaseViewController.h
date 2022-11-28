//
//  FullBaseViewController.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+addition.h"
#import "UIViewController+DHFullCallBack.h"
#import "UINavigationBar+alpha.h"

@interface FullBaseViewController : UIViewController

// 右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin;

- (NSString *)backItemImageName;
@end
