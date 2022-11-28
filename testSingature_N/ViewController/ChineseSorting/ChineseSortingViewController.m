//
//  ChineseSortingViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/11/1.
//

#import "ChineseSortingViewController.h"
#import "ChineseString.h"

@interface ChineseSortingViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property (nonatomic, strong) UILabel *sectionTitleView;
@property (nonatomic, strong) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *tempSourceArray;
@end

@implementation ChineseSortingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sectionTitleView = ({
        UILabel *sectionTitleView = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-100)/2, ([[UIScreen mainScreen]bounds].size.height-100)/2,100,100)];
        sectionTitleView.textAlignment = NSTextAlignmentCenter;
        sectionTitleView.font = [UIFont boldSystemFontOfSize:60];
        sectionTitleView.textColor = [UIColor blueColor];
        sectionTitleView.backgroundColor = [UIColor whiteColor];
        sectionTitleView.layer.cornerRadius = 6;
        sectionTitleView.layer.borderWidth = 1.f/[UIScreen mainScreen].scale;
        _sectionTitleView.layer.borderColor = [UIColor systemGroupedBackgroundColor].CGColor;
        sectionTitleView;
    });
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, [[UIScreen mainScreen]bounds].size.width - 20, 40)];
    
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    [self.navigationController.view addSubview:self.sectionTitleView];
    
    self.sectionTitleView.hidden = YES;
    
    
    NSArray *stringsToSort = [NSArray arrayWithObjects:
                              @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                              @"开源技术",@"社区",@"开发者",@"传播",
                              @"2014",@"a1",@"100",@"中国",@"暑假作业",
                              @"键盘", @"鼠标",@"hello",@"world",@"b1",
                              nil];
    
    _tempSourceArray = [stringsToSort mutableCopy];
    
    // 索引
    self.indexArray = [ChineseString IndexArray:_tempSourceArray];
    // 文本
    self.letterResultArr = [ChineseString LetterSortArray:_tempSourceArray];
    
}
#pragma mark -
#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showSectionTitle:title];
    return index;
}


#pragma mark - private
- (void)timerHandler:(NSTimer *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            self.sectionTitleView.hidden = YES;
        }];
    });
}

-(void)showSectionTitle:(NSString*)title{
    
    [self.sectionTitleView setText:title];
    self.sectionTitleView.hidden = NO;
    self.sectionTitleView.alpha = 1;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}



#pragma mark -
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor systemGroupedBackgroundColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---->%@",[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"==%@",searchBar.text);
    NSArray *temp = @[];
    if (searchBar.text.length == 0) {
        temp = [_tempSourceArray copy];
    } else {
        temp = [self getArrayWithKey:searchBar.text];
    }
    // 索引
    self.indexArray = [ChineseString IndexArray:temp];
    // 文本
    self.letterResultArr = [ChineseString LetterSortArray:temp];
    
    [self.tableView reloadData];
}

- (NSMutableArray *)getArrayWithKey:(NSString *)key {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _tempSourceArray.count ; i++) {
        NSString *temp = _tempSourceArray[i];
        if ([temp rangeOfString:key].location != NSNotFound) {
            [tempArray addObject:temp];
        }
    }
    return tempArray;
    
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
