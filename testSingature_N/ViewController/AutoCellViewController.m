//
//  AutoCellViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/25.
//

#import "AutoCellViewController.h"
#import "DHTestMessage.h"
#import "AutoCellTableViewCell.h"
#import <Masonry.h>

@interface AutoCellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTableView;
/** 数据源 */
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation AutoCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];

    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    NSString *imgName = @"123123123.png";
    for (int i = 0; i< 20; i++) {
        DHTestMessage *testModel  = [[DHTestMessage alloc]init];
        testModel.name = [@"我是标题" stringByAppendingFormat:@"%i",i];
        testModel.pathname = @"IM系统推送消息";
        testModel.fragment = @"我是内我是内容测试UI布局阿容测试UI布局阿我是内容测试UI布局阿我是内容测试UI我是内容测试UI布局阿布局阿斯试UI布局阿容测试UI布局阿我是内容测试UI布局阿我是内容测试UI我是内容测试UI布局阿布局阿斯顿顿发";
                       //则为偶数，否则为奇数
        testModel.host = i % 2 == 0 ? imgName : @"";//奇数无图
//        NSLog(@"图片：%@",testModel.host);
        [self.dataSource addObject:testModel];
    }
    [self.mainTableView reloadData];
}

- (UITableView* )mainTableView {
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        // 设置分割线的样式为None.
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 50;
        _mainTableView.scrollEnabled = YES;
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.tableFooterView = [UIView new];
    }

    return _mainTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
    DHTestMessage *model = self.dataSource[indexPath.row];
        CGFloat otherH = 100; //除了文本内容外其余的高度（根据项目需求而定）
        if (model.titleActualH > model.titleMaxH) {
            if (model.isOpen) {
                return model.titleActualH+otherH;
            } else {
                return model.titleMaxH+otherH;
            }
        } else {
            return model.titleActualH+otherH;
        }
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return self.dataSource.count;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    SystemTableViewCell *cell = [SystemTableViewCell cellWithTableView:tableView];
//    cell.systemMessage = self.dataSource[indexPath.row];
    __weak typeof(self) weakself = self;
    AutoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutoCellTableViewCell" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[AutoCellTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"AutoCellTableViewCell"];
    }
    [cell addShadowToCellInTableView:tableView atIndexPath:indexPath];
    DHTestMessage *model = self.dataSource[indexPath.row];
    cell.systemMessage = model;
//        [cell setupCellData:model];
        [cell setOpenCloseBlock:^{ //Cell点击了“展开”或“收起”
            model.isOpen = !model.isOpen;
            [weakself.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
        }];
        return cell;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    DHTestMessage *message = self.dataSource[indexPath.row];
    NSLog(@"%@",message);
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
