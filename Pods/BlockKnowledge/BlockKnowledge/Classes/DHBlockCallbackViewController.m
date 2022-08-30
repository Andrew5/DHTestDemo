//
//  DHBlockCallbackViewController.m
//  BlockKnowledge
//
//  Created by jabraknight on 2022/4/28.
//

#import "DHBlockCallbackViewController.h"

@interface DHBlockCallbackViewController ()

@end

@implementation DHBlockCallbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 100, 100);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.textColor = [UIColor redColor];
    button.titleLabel.text = @"但是发送到发送到发";
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

+ (BOOL)isWXAppInstalled{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]] ) {
        NSLog(@"没有安装微信");
        return NO;
    }
    return YES;
}

- (void)textValueFunction:(void(^)(NSString * infor))inforBlock{
    if (inforBlock) {
        inforBlock(@"无返回值的block");
    }
}

- (NSString *)textFunction:(NSString *)str{
    NSLog(@"%@",str);
    void(^test)(NSString *dic) = ^(NSString * infor){
        NSLog(@"%@",infor);
        sleep(3);
        infor = @"工程师";
        NSLog(@"%@",infor);
    };
    test(@"asdf");
    
    NSString *(^block4)(NSString *) = ^(NSString* a){
        return @"您的快递已签收";
    };
    NSLog(@"%@",block4(@"abc"));

//    return ^(NSString *par){
//        return @"k";
//    }
    return @"有返回值";
}

+ (void)numberInfor:(void (^)(NSString *))inforBlock{
    if (inforBlock) {
        inforBlock(@"中文");
    }
    
}


- (void)setReception:(receiveNoti)reception{
    _reception = reception;
    _reception(@"初始值开始");
}

- (void)setMyReturnTextBlock:(MyReturnTextBlock)myReturnTextBlock {
    _myReturnTextBlock = myReturnTextBlock;
    _myReturnTextBlock(@"初始值返回");
}

+ (BOOL)isWhiteSkinColor {
    //白色皮肤颜色
    UIColor * whiteColor = [UIColor whiteColor];
    if (whiteColor) {
        return YES;
    }
    return NO;
}

- (void)setNameP:(NSString *)nameP{
    _nameP = nameP;
    NSLog(@"%@",nameP);
}

+ (void)loadDetailCallBack:(NSString *)name callBack:(void(^)(NSString* str))finishCallBack{
//    if (FinishCallBack) {
//        FinishCallBack(@"中文");
//    }
    DHBlockCallbackViewController *bal = [DHBlockCallbackViewController new];
    [bal funcCallback:finishCallBack];
}

- (void)funcCallback:(void(^)(NSString* str))finishCallBack{
    self.CallBack = [finishCallBack copy];
    if (finishCallBack) {
        finishCallBack(@"改变");
    }
}

- (void)setCommunicationMessage:(NSDictionary *)communicationMessage {
    _communicationMessage = communicationMessage;
    NSLog(@"self.%@",self.communicationMessage);
}

- (void)getExpressionFormula
{
    NSLog(@"call getExpressionFormula");
}

// 防止多次调用
- (void)getShouldPrevent:(int)seconds{
    static BOOL shouldPrevent;
    if (shouldPrevent) return;
    shouldPrevent = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((seconds) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        shouldPrevent = NO;
    });
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
