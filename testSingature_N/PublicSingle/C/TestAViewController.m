//
//  TestAViewController.m
//  TestAPP
//
//  Created by 岳腾飞 on 2022/9/15.
//

#import "TestAViewController.h"
#import "GeneralInterest.h"
#import "TestAControl.h"

@interface TestAViewController ()

@end

@implementation TestAViewController

-(void)dealloc{
    kGIDOC(@"TestAControl");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ((TestAControl *)kGICOC(@"TestAControl")).value = @"哈哈";
    NSString *value = ((TestAControl *)kGICOC(@"TestAControl")).value;
}


@end
