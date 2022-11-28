//
//  FlipDetailViewController.m
//  FlipViewTest
//
//  Created by Mac Pro on 6/6/12.
//  Copyright (c) Dawn(use for learn,base on CAShowcase demo). All rights reserved.
//

#import "FlipDetailViewController.h"
#import "UIAlertView+BlocksKit.h"

@implementation FlipDetailViewController
@synthesize delegate;
@synthesize indexNumber;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
	self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteItem:)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    


    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notepad.png"]];
    imageView.userInteractionEnabled = YES;
    imageView.frame =  CGRectMake(10, 10, 300, 350);
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(35, 60, 200, 180)];
    textView.delegate = self;
    textView.tag = 500;
    textView.font = [UIFont fontWithName:@"KaiTi_GB2312" size:21];
    textView.backgroundColor = [UIColor clearColor];
    [imageView addSubview:textView];
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 285, 150, 30)];
    dateLabel.tag = 510;
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:17];//MarkerFelt-Thin
    dateLabel.transform = CGAffineTransformMakeRotation(-M_PI_2/20);
    [imageView addSubview:dateLabel];  


}
- (void)viewWillAppear:(BOOL)animated
{
    NSMutableArray *dataMutableArray = [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"note"];
    textView.text = [[dataMutableArray objectAtIndex:indexNumber] objectForKey:@"text"];
    dateLabel.text = [[dataMutableArray objectAtIndex:indexNumber]objectForKey:@"date"];

}
-(void)hideKeyboard:(UITapGestureRecognizer *)recognizer{
    [textView resignFirstResponder];
}
- (void)textViewDidEndEditing:(UITextView *)atextView
{
    NSMutableArray *dataMutableArray = [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"note"];
    NSDictionary *dataDic = [dataMutableArray objectAtIndex:indexNumber];
    NSString *dateString = [dataDic objectForKey:@"date"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textView.text,@"text",dateString,@"date", nil];
    [dataMutableArray replaceObjectAtIndex:indexNumber withObject:dic];
}

-(void)close:(id)sender{
    [delegate FlipDetailViewControllerClose:self];
}
-(void)deleteItem:(id)sender{
    
    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"确定要删除么？"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *dataMutableArray = [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"note"];
        [dataMutableArray removeObjectAtIndex:self->indexNumber];
        [[NSUserDefaults standardUserDefaults]setObject:dataMutableArray forKey:@"note"];
        [self->delegate refreshFlipViewForDelete];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    
    [alertController addAction:okAction];           // A
    [alertController addAction:cancelAction];       // B
    [self presentViewController:alertController animated:YES completion:nil];
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex) {
//        case 0:
//            //取消
//            break;
//        case 1:
//            //确定
//        {
//            NSMutableArray *dataMutableArray = [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"note"];
//            [dataMutableArray removeObjectAtIndex:indexNumber];
//            [[NSUserDefaults standardUserDefaults]setObject:dataMutableArray forKey:@"note"];
//            [delegate refreshFlipViewForDelete];
//        }
//            break;
//        default:
//            break;
//    }
//}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.delegate = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
