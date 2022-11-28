//
//  FullTavleviewViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/11/2.
//

#import "FullTavleviewViewController.h"
#import "FullBaseWebViewController.h"

@interface FullTavleviewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation FullTavleviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemsArray = @[@[@"意见反馈",@"关于我们",@"版本信息",@"清除缓存"],@[@"修改密码"],@[@"退出登录"]].mutableCopy;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar DH_setBackgroundColor:[UIColor redColor]];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar DH_reset];

    [super viewWillDisappear:animated];
}
#pragma mark ----- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return _itemsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemsArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _itemsArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    return cell;
}

/// 取消系统cell的separatorView
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _itemsArray.count -1) {
        [self performSelector:@selector(setSeparatorLineColor:) withObject:cell afterDelay:0.1];
    }
}

- (void)setSeparatorLineColor:(UITableViewCell *)cell {
    // 获取系统cell的separatorView
    UIView * view = [cell valueForKey:@"separatorView"];
    view.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
        FullBaseWebViewController *webView = [FullBaseWebViewController new];
        webView.urlString = @"https://www.baidu.com";
        [self.navigationController pushViewController:webView animated:YES];
    
    
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
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
