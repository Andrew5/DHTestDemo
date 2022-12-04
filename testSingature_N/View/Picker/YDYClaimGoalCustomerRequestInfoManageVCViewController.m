//
//  YDYClaimGoalCustomerRequestInfoManageVCViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/8.
//

#import "YDYClaimGoalCustomerRequestInfoManageVCViewController.h"
#import "DHJiugonggeView.h"
#import "Masonry.h"

@interface YDYClaimGoalCustomerRequestInfoManageVCViewController ()
@property (strong, nonatomic) DHJiugonggeView *manageView;

@end

@implementation YDYClaimGoalCustomerRequestInfoManageVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@,%@",self.ID,self.type);

    // Do any additional setup after loading the view.
    self.manageView = [[DHJiugonggeView alloc] init];
    self.manageView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.manageView];
    [self.manageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
        make.height.equalTo(@(500));
    }];
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
