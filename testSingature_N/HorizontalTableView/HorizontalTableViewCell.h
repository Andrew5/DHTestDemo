//
//  HorizontalTableViewCell.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableViewCell : UIView

@property (nonatomic, copy) NSString *reuseIdentifier;

@property (nonatomic, assign) NSInteger row;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)prepareForReuse;

@end
