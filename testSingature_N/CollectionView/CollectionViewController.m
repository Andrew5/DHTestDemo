//
//  CollectionViewController.m
//  testSingature
//
//  Created by jabraknight on 2022/3/3.
//  Copyright © 2022 zk. All rights reserved.
//

#import "CollectionViewController.h"
#import "Masonry.h"
#import "YDYContactsCollectionCell.h"
#import "YDYAutoresizeLabelFlowLayout.h"
#import "XDCollectionHeaderLayout.h"


@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HorizontalCollectionLayoutDelegate,XDAutoresizeLabelFlowLayoutDataSource>
@property (nonatomic, strong) UICollectionView *mycollectionView;
/** <#strong属性注释#> */
@property (nonatomic, strong) NSArray *titarr;
@end

@implementation CollectionViewController


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.titarr = @[@"阿娥地吧",@"大发多少发多少",@"阿发大发大发的是",@"剪短发尼康地方看到发那节课",@"iuuehwiuhf",@"但能",@"多少发多少分",@"ui饿nc",@"好",@"是的发送",@"是的送"];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)injected{
    NSLog(@"I've been injected: %@", self);
    NSLog(@"这里调用修改页面布局的代码，如这里调用了viewDidLoad方法");
    [self createUI];
//当然也可以直接 redBtn.backgroundColor = [UIColor yellowColor];  redBtn改成全局的。

}
#pragma mark - Private

- (void)createUI {
    [self.view addSubview:self.mycollectionView];
    self.mycollectionView.layer.borderColor = [UIColor brownColor].CGColor;
    self.mycollectionView.layer.borderWidth = 1.0;
    [self makeConstraints];
    [self.mycollectionView reloadData];
}

- (void)makeConstraints {
    [self.mycollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_offset(50);
    }];
    
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(100, 120);
//
//}
//上下Line spacing（每行的间距） 实测左右间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}
////左右Inter cell spacing（每行内部cell item的间距）minimumInteritemSpacing
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}
    //
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YDYContactsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDYContactsCollectionCell class]) forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.layer.borderWidth = 1.0;
    cell.nsyerrt = [NSString stringWithFormat:@"%ld-%@",indexPath.row,self.titarr[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"输出--%ld",(long)indexPath.item);
}

#pragma mark - MSSAutoresizeLabelFlowLayout 代理方法
- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    return self.titarr[indexPath.item];
}

#pragma mark - dele
// 用协议传回 item 的内容,用于计算 item 宽度
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath{
    return self.titarr[indexPath.item];
}
- (void)collectionView:(CGFloat)height {
    NSLog(@"输出高度--%lf",height);
    [self.mycollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
    [self.mycollectionView layoutIfNeeded];
    
}
////计算collectionView的高度
//-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (collectionView == self.mycollectionView) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 设置高度
//            CGFloat tagViewHeight = self.mycollectionView.contentSize.height;
//            [self.mycollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.equalTo(@(tagViewHeight));
//            }];
//
//            [self.mycollectionView layoutIfNeeded];
//
//        });
//    }
//}
//// 用协议传回 headerSize 的 size
//- (CGSize)collectionViewDynamicHeaderSizeWithIndexPath:(NSIndexPath *)indexPath{
//
//}
//// 用协议传回 footerSize 的 size
//- (CGSize)collectionViewDynamicFooterSizeWithIndexPath:(NSIndexPath *)indexPath{
//
//}

#pragma mark - Public



#pragma mark - Getter
- (UICollectionView *)mycollectionView {
    if (!_mycollectionView) {
        XDCollectionHeaderLayout *layout = [[XDCollectionHeaderLayout alloc]init];
//        layout.itemSize = CGSizeMake(100, 30);
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = 10;
//        layout.headerViewHeight = 35;
//        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, 0, 0, 10);
//        layout.minimumLineSpacing = 10.0;
//        layout.minimumInteritemSpacing = 8.0;
//        [layout invalidateLayout];

        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.estimatedItemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 30);
        _mycollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mycollectionView.backgroundColor = [UIColor whiteColor];
        [_mycollectionView registerClass:[YDYContactsCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([YDYContactsCollectionCell class])];
        _mycollectionView.showsVerticalScrollIndicator = FALSE;
        _mycollectionView.showsHorizontalScrollIndicator = FALSE;
        _mycollectionView.dataSource = self;
        _mycollectionView.delegate = self;
        _mycollectionView.alwaysBounceVertical = YES;

    }
    return _mycollectionView;
}


#pragma mark - Setter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
