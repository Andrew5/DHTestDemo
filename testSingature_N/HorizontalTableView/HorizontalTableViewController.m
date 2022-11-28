//
//  HorizontalTableViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/31.
//

#import "HorizontalTableViewController.h"
#import "HorizontalTableView.h"

@interface HorizontalTableViewController ()<HorizontalTableViewDataSourse>
@property (nonatomic, strong) HorizontalTableView *hTableView;

@end

@implementation HorizontalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}
- (void)createUI {
    self.hTableView = [[HorizontalTableView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
    self.hTableView.dataSource = self;
    [self.view addSubview:self.hTableView];
}

#pragma mark - datasource

- (NSInteger)numberOfRowsWithHorizontalTableView:(HorizontalTableView *)horizontalTableView{
    return 10;
}

- (HorizontalTableViewCell *)horizontalTableView:(HorizontalTableView *)horizontalTableView cellForRow:(NSInteger)row{
    static NSString *cellID = @"cellID";
    HorizontalTableViewCell *cell = [horizontalTableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HorizontalTableViewCell alloc] initWithReuseIdentifier:cellID];
        cell.backgroundColor = [UIColor yellowColor];
        cell.layer.borderColor = [UIColor redColor].CGColor;
        cell.layer.borderWidth = 1;
    }
    return cell;
}

- (CGFloat)horizontalTableView:(HorizontalTableView *)horizontalTableView widthForRow:(NSInteger)row{
    return 60;
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
