//
//  UICalViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/26.
//

#import "UICalViewController.h"
enum Operation
{
    ADD = 0,//Âä?
    Reduce, //Âá?
    Multi,  //‰π?
    Div     //Èô?
};
@interface UICalViewController (){
    UILabel * resultLabel;
    NSMutableString * inputStr;
    NSMutableString * currentStr;
    NSMutableArray  * expressArray;
    NSMutableArray  * expressAddAndReduceArray;
    enum Operation OP;
}

@property (strong, nonatomic) UIView *rootVIew;

@end

@implementation UICalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)createUI {
    self.rootVIew = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.rootVIew];
    expressArray = [[NSMutableArray alloc] init];
    expressAddAndReduceArray = [[NSMutableArray alloc] init];
    currentStr = [[NSMutableString alloc] init];
    
    //ÂÆöÂà∂ËæìÂÖ•Ê°?
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
    resultLabel.backgroundColor = [UIColor grayColor];
    resultLabel.textColor = [UIColor redColor];
    resultLabel.textAlignment = UITextAlignmentRight;
    [self.rootVIew addSubview:resultLabel];

    
    inputStr = [[NSMutableString alloc] initWithCapacity:5];//ËæìÂÖ•Ê°ÜÁöÑÂÜÖÂÆπÂÇ®Â≠òÁ©∫Èó¥
    //ÂÆöÂà∂Ê∂àÈô§ Ê∏ÖÈô§Â±èÂπïÂÜÖÂÆπ
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearBtn.frame = CGRectMake(10, 60, 40, 40);
    [clearBtn setTitle:@"C" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteBtn.frame = CGRectMake(270, 60, 40, 40);
    [deleteBtn addTarget:self action:@selector(deleteStr:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"del" forState:UIControlStateNormal];
    [self.rootVIew addSubview:deleteBtn];
    
    //ÂÆöÂà∂Êï∞Â≠óÈîÆÁõò
    NSString *titleStr = @"7 8 9 + 4 5 6 - 1 2 3 * . 0 = /";
    NSArray *titleArray = [titleStr componentsSeparatedByString:@" "];
    NSArray *mothodArray = [NSArray arrayWithObjects:@"showNum:",
                            @"showNum:",
                            @"showNum:",
                            @"add:",
                            @"showNum:",
                            @"showNum:",
                            @"showNum:",
                            @"reduce:",
                            @"showNum:",
                            @"showNum:",
                            @"showNum:",
                            @"multi:",
                            @"dot:",
                            @"showNum:",
                            @"equal:",
                            @"div:",
                            nil];
    //ÂÆöÂà∂Êï∞Â≠óÈîÆÁõòÊéíÂ∫è
    for (int i = 0; i<4; i++)
    {
        for (int j = 0; j<4; j++)
        {
            int index = i+j*4;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(50+j*60, i*60+120, 40, 40);//ÊåâÈîÆÂùêÊ†á‰ΩçÁΩÆ
            btn.backgroundColor = [UIColor grayColor];
            [btn setTitle:[titleArray objectAtIndex:index] forState:UIControlStateNormal];
            NSString *mothodStr = [mothodArray objectAtIndex:index];
            SEL _mothod = NSSelectorFromString(mothodStr);
            [btn addTarget:self action:_mothod forControlEvents:UIControlEventTouchUpInside];
            [self.rootVIew addSubview:btn];
        }
    }
    
    
    [self.rootVIew addSubview:clearBtn];
}

#pragma ÂÆöÂÄºËøêÁÆóÊñπÊ≥?
-(void)showNum:(UIButton *)sender
{
    NSString *_title = sender.titleLabel.text;
    [inputStr appendFormat:@"%@",_title];
    [currentStr appendFormat:@"%@",_title];
    resultLabel.text = inputStr;
}
-(void)add:(UIButton *)sender
{
    OP = ADD;
    NSString *_title = sender.titleLabel.text;
    [expressArray addObject:currentStr];
    [expressArray addObject:_title];
    [inputStr appendFormat:@"%@",_title];
    resultLabel.text = inputStr;
    currentStr = nil;
    currentStr = [[NSMutableString alloc] init];
    NSLog(@"%@",expressArray);
}
-(void)reduce:(UIButton *)sender
{
    OP = Reduce;
    NSString *_title = sender.titleLabel.text;
    [expressArray addObject:currentStr];
    [expressArray addObject:_title];
    [inputStr appendFormat:@"%@",_title];
    resultLabel.text = inputStr;
    currentStr = nil;
    currentStr = [[NSMutableString alloc] init];
}
-(void)multi:(UIButton *)sender
{
    OP = Multi;
    NSString *_title = sender.titleLabel.text;
    [expressArray addObject:currentStr];
    [expressArray addObject:_title];
    [inputStr appendFormat:@"%@",_title];
    resultLabel.text = inputStr;
    currentStr = nil;
    currentStr = [[NSMutableString alloc] init];
}
-(void)div:(UIButton *)sender
{
    OP = Div;
    NSString *_title = sender.titleLabel.text;
    [expressArray addObject:currentStr];
    [expressArray addObject:_title];
    [inputStr appendFormat:@"%@",_title];
    resultLabel.text = inputStr;
    currentStr = nil;
    currentStr = [[NSMutableString alloc] init];
}
-(void)dot:(UIButton *)sender
{
    //OP = Div;
    NSString *_title = sender.titleLabel.text;
    [currentStr appendFormat:@"%@",_title];
    [inputStr appendFormat:@"%@",_title];
    resultLabel.text = inputStr;
}
#pragma Âà§Êñ≠ËøêÁÆóÁ¨?
-(void)resultOfMultiAndDiv
{
    for (int i = 0; i < [expressArray count]; i++) {
        NSLog(@"%@",expressArray);
        NSString *_op = [expressArray objectAtIndex:i];
        if ([_op isEqualToString:[NSString stringWithFormat:@"%s","*"]]) {
//            if ([[expressAddAndReduceArray lastObject] rangeOfString:@"."].location != NSNotFound) {
                float a = [[expressAddAndReduceArray lastObject] floatValue];
                float b = [[expressArray objectAtIndex:i+1] floatValue];
                float c = a*b;
                [expressAddAndReduceArray removeLastObject];
                [expressAddAndReduceArray addObject:[NSString stringWithFormat:@"%f",c]];
            i = i + 1;
        }else if ([_op isEqualToString:[NSString stringWithFormat:@"%s","/"]]) {
//            if ([[expressAddAndReduceArray lastObject] rangeOfString:@"."].location != NSNotFound) {
                float a = [[expressAddAndReduceArray lastObject] floatValue];
                float b = [[expressArray objectAtIndex:i+1] floatValue];
                float c = a*b;
                [expressAddAndReduceArray removeLastObject];
                [expressAddAndReduceArray addObject:[NSString stringWithFormat:@"%f",c]];
            i = i + 1;
        }else{
            [expressAddAndReduceArray addObject:[expressArray objectAtIndex:i]];
        }
    }
}
//FIXME: 精确计算结果修复 204
-(float)resultOfAddAndReduce
{
    NSLog(@"%@",expressAddAndReduceArray);
    float sum;
    sum = [[expressAddAndReduceArray objectAtIndex:0] floatValue];
    NSDecimalNumber *result;
    for (int i = 1; i < [expressAddAndReduceArray count]; i++) {
        NSString *_op = [expressAddAndReduceArray objectAtIndex:i];
        if ([_op isEqualToString:[NSString stringWithFormat:@"%s","+"]]) {
            NSDecimalNumber *g_firstnum =[NSDecimalNumber decimalNumberWithString:[expressAddAndReduceArray objectAtIndex:i+1]];
            NSDecimalNumber *g_twonum =[NSDecimalNumber decimalNumberWithString:[expressAddAndReduceArray objectAtIndex:i]];


            NSDecimalNumberHandler *roundup = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:10 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            result = [g_firstnum decimalNumberByAdding:g_twonum withBehavior:roundup];

//            float b = [[expressAddAndReduceArray objectAtIndex:i+1] floatValue];
//            sum = sum + b;
        }
        if ([_op isEqualToString:[NSString stringWithFormat:@"%s","-"]]) {
            float b = [[expressAddAndReduceArray objectAtIndex:i+1] floatValue];
            sum = sum - b;
        }
    }
    
    return sum;
}
- (NSString *)removeFloatAllZero:(float)string{

    NSString * outNumber = [NSString stringWithFormat:@"%@",@(string)];
    //价格格式化显示
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString * formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[outNumber doubleValue]]];
    //获取要截取的字符串位置
    NSRange range = [formatterString rangeOfString:@"."];
    if (range.length >0 ) {
        NSString * result = [formatterString substringFromIndex:range.location];
        if (result.length >= 4) {
            formatterString = [formatterString substringToIndex:formatterString.length - 1];
        }
    }
    
    return formatterString;
}

    
#pragma Ëß¶ÂèëÊåâÈîÆ Ê∏ÖÈô§
-(void)equal:(UIButton *)sender
{
    [expressArray addObject:currentStr];
    NSLog(@"%@",expressArray);
    [self resultOfMultiAndDiv];
    float sum;
    sum = [self resultOfAddAndReduce];
    NSString *resultstr =  [self removeFloatAllZero:sum];
    resultLabel.text = resultstr;
    [resultLabel setTextColor:[UIColor blueColor]];
    currentStr = nil;
    currentStr = [[NSMutableString alloc] init];
}

-(void)clear:(UIButton *)sender//ÂèÇÊï∞Â∞±ÊòØclearBtn
{
    [inputStr setString:@""];
    currentStr = nil;
    currentStr = [[NSMutableString alloc] init];
    [expressArray removeAllObjects];
    [expressAddAndReduceArray removeAllObjects];
    resultLabel.text = inputStr;
    [resultLabel setTextColor:[UIColor redColor]];
}

-(void)deleteStr:(id)sender
{
    //Âº∫Âà∂ËΩ¨Âåñ
    //UIButton *btn = (UIButton *)sender;
    if (inputStr.length!=0)
    {
        NSRange r = {inputStr.length - 1,1};
        [inputStr deleteCharactersInRange:r];
        resultLabel.text = inputStr;
    }
    
    
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
