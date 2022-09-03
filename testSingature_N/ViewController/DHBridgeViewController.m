//
//  DHBridgeViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import "DHBridgeViewController.h"

@interface DHBridgeViewController ()

@end

@implementation DHBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *view2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    [view2 addTarget:self action:@selector(xxxxxxxx) forControlEvents:(UIControlEventTouchUpInside)];
    NSLog(@"222=%@", NSStringFromCGRect(view2.frame));
    
    // Do any additional setup after loading the view.
}
- (void)xxxxxxxx {
    if (_hintBlock) {
        _hintBlock(@"传回值内容哈");
    }
    if (_refreshHintLabelBlock) {
        _refreshHintLabelBlock(@"传回值内容ha");
    }
    if ([self.secondDelegate respondsToSelector:@selector(refreshHintLabel:)]) {
        [self.secondDelegate refreshHintLabel:@"代理传值"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}
/*
 // 计算cell高度
 - (CGFloat)tableView:(UITableView *)tableView :(NSIndexPath *)indexPath {
     Model *model = [self.dataArray objectAtIndex:indexPath.row];
     return [Cell cellHeightWith:model];
 }
 
 + (CGFloat)cellHeightWith:(Model *)model{
     CGFloat cellHeight = 60;
     if (model && model.expand) {
         NSString *log = model.content;
         NSTimeInterval timeInterval = model.timeInterval;
         NSString *time = [DHDate dateFormatTimeInterval:timeInterval];
         NSString *content = [NSString stringWithFormat:LocalizedString(@"%@\n触发时间: %@"),log,time];
         
         UILabel *logLabel = [[UILabel alloc] init];
         logLabel.textColor = [UIColor redCole];
         logLabel.font = [UIFont systemFontOfSize:24];
         logLabel.text = content;
         logLabel.numberOfLines = 0;
         CGSize size = [logLabel sizeThatFits:CGSizeMake(kScreenWidth-kSizeFrom750_Landscape(32)*2-kSizeFrom750_Landscape(25)-kSizeFrom750_Landscape(12)*2, MAXFLOAT)];
         cellHeight = kSizeFrom750_Landscape(10) + size.height + kSizeFrom750_Landscape(10);
     }
     return cellHeight;
 }
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
