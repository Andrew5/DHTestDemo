//
//  HorizontalTableView.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import "HorizontalTableView.h"

@interface HorizontalTableView()

@property (nonatomic, strong) NSMutableDictionary *reUsedCells;
@property (nonatomic, strong) NSMutableArray<__kindof HorizontalTableViewCell *> *currentVisibleCells;
@property (nonatomic, copy) NSArray *currentVisibleRowInfos;

@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, copy) NSArray *allRowInfos;

@end

@implementation HorizontalTableView

@dynamic delegate;

- (void)reloadData{
    for (UIView *view in self.currentVisibleCells) {
        [view removeFromSuperview];
    }
    [self.currentVisibleCells removeAllObjects];
    self.currentVisibleRowInfos = nil;
    [self checkVisibleRowInfosWhenMove];
}

- (void)displayRow:(NSInteger)row animation:(BOOL)animation{
    RowInfo rowInfo = [self.allRowInfos[row] rowInfoValue];
    [self setContentOffset:CGPointMake(rowInfo.left, 0) animated:animation];
}

#pragma mark -

- (void)addCellWithRowInfo:(RowInfo)rowInfo{
    if (self.dataSource) {
        HorizontalTableViewCell *cell = [self.dataSource horizontalTableView:self cellForRow:rowInfo.row];
        cell.frame = CGRectMake(rowInfo.left, 0, rowInfo.width, self.frame.size.height);
        cell.row = rowInfo.row;
        [self addSubview:cell];
        [self.currentVisibleCells addObject:cell];
    }
}

#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    [self checkVisibleRowInfosWhenMove];
}

- (void)checkVisibleRowInfosWhenMove{
    if (self.dataSource) {
        
        RowInfo leftRowInfo = [self.currentVisibleRowInfos.firstObject rowInfoValue];
        RowInfo rightRowInfo = [self.currentVisibleRowInfos.lastObject rowInfoValue];
        CGFloat screenLeft = self.contentOffset.x;
        CGFloat screenRight = self.contentOffset.x + self.frame.size.width;
        
        if (screenLeft < leftRowInfo.left ||
            screenLeft >= leftRowInfo.right ||
            screenRight > rightRowInfo.right ||
            screenRight <= rightRowInfo.left) {
            
            NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.currentVisibleRowInfos];
            NSArray *cells = [self.currentVisibleCells copy];
            
            NSInteger num = [self.dataSource numberOfRowsWithHorizontalTableView:self];
            CGFloat width = 0;
            NSMutableArray *rowInfos = [NSMutableArray arrayWithCapacity:10];
            NSMutableArray *allRowInfos = [NSMutableArray arrayWithCapacity:10];
            
            for (int i = 0; i < num; i++) {
                CGFloat left = width;
                CGFloat cellWidth = [self.dataSource horizontalTableView:self widthForRow:i];
                CGFloat right = width + cellWidth;
                width += cellWidth;
                
                RowInfo row = RowInfoMake(i, left, width, cellWidth);
                [allRowInfos addObject:[NSValue valueWithRowInfo:row]];
                
                if ((left >= screenLeft &&
                    left < screenRight) ||
                    (right > screenLeft &&
                    right <= screenRight)) {

                    [rowInfos addObject:[NSValue valueWithRowInfo:row]];
                    NSArray *remain = [tmp copy];
                    BOOL hasRowInfo = NO;
                    for (NSValue *value in remain) {
                        RowInfo rowInfo = [value rowInfoValue];
                        if (rowInfo.row == i) {
                            hasRowInfo = YES;
                            [tmp removeObject:value];
                            break;
                        }
                    }
                    //?????????cell
                    if (!hasRowInfo) {
                        [self addCellWithRowInfo:row];
                    }

                }
            }
            
            self.allRowInfos = [allRowInfos copy];
            
            self.maxWidth = width;
            self.contentSize = CGSizeMake((width > self.bounds.size.width ? width : self.bounds.size.width + 1), CGRectGetHeight(self.frame));
            
            //??????????????????cell
            for (HorizontalTableViewCell *cell in cells) {
                for (NSValue *value in tmp) {
                    RowInfo row = [value rowInfoValue];
                    if (row.row == cell.row) {
                        [cell prepareForReuse];
                        [cell removeFromSuperview];
                        [self.currentVisibleCells removeObject:cell];
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.reUsedCells[cell.reuseIdentifier]];
                        [arr addObject:cell];
                        self.reUsedCells[cell.reuseIdentifier] = arr;
                    }
                }
            }
            if ([self.dataSource respondsToSelector:@selector(horizontalTableView:displayCells:)]) {
                [self.dataSource horizontalTableView:self displayCells:self.currentVisibleCells];
            }
            self.currentVisibleRowInfos = [rowInfos copy];
        }
        
    }
}

#pragma mark - readonly

- (NSArray<HorizontalTableViewCell *> *)visibleCells{
    return self.currentVisibleCells;
}

- (NSArray *)visibleRowInfos{
    return self.currentVisibleRowInfos;
}

#pragma mark - ??????
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.reUsedCells[identifier]];
    if (arr.count > 0) {
        HorizontalTableViewCell *cell = arr.firstObject;
        [arr removeObject:cell];
        self.reUsedCells[cell.reuseIdentifier] = arr;
        return cell;
    }
    return nil;
}

#pragma mark - set get
- (NSMutableArray<HorizontalTableViewCell *> *)currentVisibleCells{
    if (!_currentVisibleCells) {
        _currentVisibleCells = [NSMutableArray arrayWithCapacity:5];
    }
    return _currentVisibleCells;
}
- (NSMutableDictionary *)reUsedCells{
    if (!_reUsedCells) {
        _reUsedCells = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _reUsedCells;
}

@end

@implementation NSValue (RowInfo)
+ (NSValue *)valueWithRowInfo:(RowInfo)rowInfo{
    return [NSValue valueWithBytes:&rowInfo objCType:@encode(RowInfo)];
}
- (RowInfo)rowInfoValue{
    RowInfo rowInfo;
    [self getValue:&rowInfo];
    return rowInfo;
}
@end
