//
//  FullHomeViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import "FullHomeViewController.h"
#import "SDCycleScrollView.h"
#import "UINavigationBar+alpha.h"

@interface FullHomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate> {
    NSArray *_dataSource;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIColor *navColor;
@end

@implementation FullHomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar DH_reset];

    if (self.navColor) {
        [self.navigationController.navigationBar DH_setBackgroundColor:self.navColor];
    }else{//默认导航栏背景颜色
        [self.navigationController.navigationBar DH_setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navColor = [self.navigationController.navigationBar DH_getBackgroundColor];
    [self.navigationController.navigationBar DH_reset];
}

/**
 懒加载轮播图
 @return _cycleScrollView
 */
- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 192.f) delegate:self placeholderImage:nil];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeCenter;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.imageURLStringsGroup = @[@"banner1",@"banner2",@"personCenterbg"];
        _cycleScrollView.currentPageDotColor = [UIColor blackColor]; // 自定义分页控件小圆标颜色
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}
/**
 懒加tableView

 @return _table
 */
// 待优化 修改
#define IS_IPHONE ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define iPhoneX ([UIScreen mainScreen].bounds.size.width == 375.0f) && ([UIScreen mainScreen].bounds.size.height == 812.0f) && IS_IPHONE

- (UITableView *)table {
    
    if (_table == nil) {
        _table  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- (iPhoneX ? (49.f + 34.f) : 49.f)) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = [UIView new];
        _table.tableHeaderView = self.cycleScrollView;
        _table.rowHeight = 70.f;
    }
    return _table;
}

- (void)scanEwm:(UIBarButtonItem *)sender {
    
    NSLog(@"ewm");
}

- (void)searchAction:(UIBarButtonItem *)sender {
    
    NSLog(@"searchAction");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    _dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
    self.navigationItem.title = @"推荐";
    [self.view addSubview:self.table];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"copy"] style:UIBarButtonItemStylePlain target:self action:@selector(scanEwm:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"QQ"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

// 监听scrollView的滚动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.table) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 0) {
            CGFloat alpha = (offsetY - 64) / 64 ;
            alpha = MIN(alpha, 0.99);
            [self.navigationController.navigationBar DH_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
            if (alpha >= 0.99) {
//                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                self.navigationItem.title = @"推荐";
            }
        } else {// 往下拉
            [self.navigationController.navigationBar DH_setBackgroundColor:[UIColor lightGrayColor]];
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            self.navigationItem.title = @"";
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *aView = [UIView new];
    aView.frame = CGRectMake(0, 0, tableView.frame.size.width, 0.0001);
    return aView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
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
