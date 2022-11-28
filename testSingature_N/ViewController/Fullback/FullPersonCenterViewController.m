//
//  FullPersonCenterViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/11/2.
//

#import "FullPersonCenterViewController.h"
#import "FullRecommandViewController.h"

@interface FullPersonCenterViewController ()

@end

@implementation FullPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"setting" highIcon:nil target:self action:@selector(messageItemDidAction:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"message" highIcon:nil target:self action:@selector(setItemDidAction:)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar DH_setBackgroundColor:[UIColor greenColor]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar DH_reset];

}
- (void)messageItemDidAction:(UIBarButtonItem *)sender {
    
}
- (void)setItemDidAction:(UIBarButtonItem *)sender {
    // 拦截导航“返回”按钮事件，并且不屏蔽此VC的全屏返回手势
    FullRecommandViewController *popBlockTest = [FullRecommandViewController new];
    [self.navigationController pushViewController:popBlockTest animated:YES];
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
