//
//  FullUserGuideViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/31.
//

#import "FullUserGuideViewController.h"
#import "FullRootTabbarController.h"

@interface FullUserGuideViewController (){
    UIScrollView *_scrollView;
}
@end

@implementation FullUserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuideView];
}

- (void)initGuideView {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    NSArray *iPhone4Array = @[@"guidePage1@2x", @"guidePage2@2x", @"guidePage3@2x"];
    NSArray *iPhone5Array = @[@"guidePage1-568h", @"guidePage2-568h", @"guidePage3-568h"];
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * iPhone5Array.count, 0);
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton addTarget:self action:@selector(showMainUI:) forControlEvents:UIControlEventTouchUpInside];
    aButton.frame = CGRectMake((iPhone5Array.count-1) * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    for (NSUInteger i = 0; i < iPhone5Array.count; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        iv.image = [UIImage imageNamed:iPhone5Array[i]];
        [_scrollView addSubview:iv];
    }
    aButton.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:aButton];
    [_scrollView bringSubviewToFront:aButton];
}

- (void)showMainUI:(UIButton *)sender {
    
    FullRootTabbarController *rootVC = [[FullRootTabbarController alloc]init];
    rootVC.modalPresentationStyle = 0;
    [self presentViewController:rootVC animated:YES completion:^{
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
