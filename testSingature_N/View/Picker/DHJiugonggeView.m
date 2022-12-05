//
//  DHJiugonggeView.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/7.
//

#import "DHJiugonggeView.h"
#import "Masonry.h"
#import <UIKit/UIKit.h>
#import "DHJiugonggeLoadPhoto.h"
#import "YDYSalesRecordDetailInfoListInfoItemCell.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height
@interface DHJiugonggeView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *addressImage;
@property (strong, nonatomic) UILabel *addressLabel;

@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) UIButton *cameraButton;

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray<NSString *> *imagePathArray;

@property (strong, nonatomic) DHJiugonggeLoadPhoto *photoModel;//照片选择器

@property (strong, nonatomic) UILabel *photoLabel;
@property (strong, nonatomic) UILabel *photoInputLabel;


@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIImageView *locationRightImage;

@property (strong, nonatomic) UIButton *locationButton;


@end

@implementation DHJiugonggeView

- (UILabel *)photoInputLabel {
    if (!_photoInputLabel) {
        _photoInputLabel = [[UILabel alloc] init];
        _photoInputLabel.text = @"最少一张";
        _photoInputLabel.textColor = UIColor.redColor;
        _photoInputLabel.font = [UIFont systemFontOfSize:15];
    }
    return _photoInputLabel;
}

- (UIImageView *)locationRightImage {
    if (!_locationRightImage) {
        _locationRightImage = [[UIImageView alloc] init];
        _locationRightImage.image = [UIImage imageNamed:@"stockCheck_lock_右箭头"];
    }
    return _locationRightImage;
}

- (UIButton *)locationButton {
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _locationButton;
}


- (NSMutableArray<NSString *> *)imagePathArray {
    if (!_imagePathArray) {
        _imagePathArray = [NSMutableArray array];
    }
    return _imagePathArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, 15+15+38+94+76)];
    if (self) {
        self.backgroundColor =UIColor.grayColor;
        
        [self addSubview:self.collectionV];
        [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.width.equalTo(@(Screen_Width));
            make.top.equalTo(self).offset(30);
            make.height.equalTo(@(500));
        }];
        self.collectionV.hidden = YES;

//        __weak typeof(self) weakSelf = self;
        //开始定位
//        self.locationModel.doneHandle = ^{
//            //定位
//            weakSelf.poi = weakSelf.locationModel.addressArray.firstObject;
//            weakSelf.addressLabel.text = weakSelf.poi.address;
//        };
//        [self.locationModel startUpdatingLocation];
        
    }
    return self;
}

#pragma mark - UICollectionView

- (UICollectionView *)collectionV {
    if (!_collectionV) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 15.5, 0, 15.5);
        layout.itemSize = CGSizeMake(85, 85);
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        [_collectionV registerClass:[YDYSalesRecordDetailInfoListInfoItemCell class] forCellWithReuseIdentifier:@"YDYSalesRecordDetailInfoListInfoItemCell"];
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.showsVerticalScrollIndicator = NO;
    }
    return _collectionV;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagePathArray.count;
}
/** 给 UIImageView设置网络图片,自带缺省图和加载失败图片*/
- (void)sdSetImageWithURLWithPlaceholderImageAndFailImage:(NSString *)url forImageView:(UIImageView *)imageView{
    if (url.length < 0 || [url isEqualToString:@""] || !url) {
        return;
    }
    //封装一下
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"QQ"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
    }];
    
//    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:WBPlaceholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error) {
//            NSLog(@"error:%@",error);
//            imageView.image = @"QQ";
//        }
//    }];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDYSalesRecordDetailInfoListInfoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YDYSalesRecordDetailInfoListInfoItemCell" forIndexPath:indexPath];
    [self sdSetImageWithURLWithPlaceholderImageAndFailImage:self.imagePathArray[indexPath.row] forImageView:cell.icon];
    
    cell.deleteButton.hidden = NO;
    __weak typeof(self) weakSelf = self;
    cell.deleteHandle = ^{
        if (weakSelf.imagePathArray.count > indexPath.row) {
            [weakSelf.imagePathArray removeObjectAtIndex:indexPath.row];
        }
        [weakSelf.collectionV reloadData];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //此处应该有点击查看大图
    if (self.imagePathArray.count <= indexPath.row) {
        return;
    }
    NSLog(@"预览图片");

    NSLog(@"预览图片");
//    //准备数据源
//    NSMutableArray *browseItemArray = [NSMutableArray array];
//    NSMutableArray *sourceImageArr = self.imagePathArray.mutableCopy;
//
//    for (NSString *img in sourceImageArr) {
//        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
//        data.url = [NSURL URLWithString:img];
//        [browseItemArray addObject:data];
//    }
//    //赋值数据源并显示
//    YBImageBrowser *browser = [YBImageBrowser new];
//    browser.enterTransitionType = YBImageBrowserTransitionTypeFade;
//    browser.outTransitionType = YBImageBrowserTransitionTypeFade;
//    browser.autoHideSourceObject = NO;//是否自动隐藏资源对象
//    browser.dataSourceArray = browseItemArray;
//    browser.currentIndex = indexPath.row;
//    [browser show];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
