//
//  FullRecommandViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/11/2.
//

#import "FullRecommandViewController.h"
#import "FullTavleviewViewController.h"
#import "SVandTVViewController.h"

@interface FullRecommandViewController ()

@end

@implementation FullRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"拦截back事件";
    __weak typeof(self) weakSelf = self;
    self.callBackBlock = ^(UIBarButtonItem * _Nonnull backItem) {

    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int value = arc4random()%+5;
    if (value > 2){//3 2 1 0
        [self pop];
    }else{
        [self pop1];
    }
}
- (void)pop {
    FullTavleviewViewController*popBlockTest = [FullTavleviewViewController new];
    [self.navigationController pushViewController:popBlockTest animated:YES];
}
- (void)pop1 {
    SVandTVViewController *setVC = [SVandTVViewController new];
    [self.navigationController pushViewController:setVC animated:YES];
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
