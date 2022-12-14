//
//  ViewController.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)loadManyDatas:(void(^)(NSString * infor))inforBlock;

@end

