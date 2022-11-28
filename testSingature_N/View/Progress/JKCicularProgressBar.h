//
//  JKCicularProgressBar.h
//  Wopet
//
//  Created by mac on 2022/5/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JKCicularProgressBar;
@protocol JKCicularProgressBarDelegate <NSObject>
- (void)cicularProgressBartTimeOut;
- (void)cicularProgressBarSuccessful;
- (void)cicularProgressBarFailure;
@end

@interface JKCicularProgressBar : UIView
@property(nonatomic, weak) id<JKCicularProgressBarDelegate>delegate;
@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign)NSInteger time;
@property(nonatomic, assign)CGFloat interval;
@property(nonatomic, strong)UIImageView * statusImageView;
@property(nonatomic, strong)UIColor *progerssColor;
@property(nonatomic, strong)UIColor *progerssBackgroundColor;
@property(nonatomic, assign)CGFloat progerWidth;
@property(nonatomic, strong)UILabel * progressLabel;
@property(nonatomic, assign)NSInteger transitionTime;
- (void)start;
- (void)successful;
- (void)stop;
- (void)failure;

@end

NS_ASSUME_NONNULL_END
