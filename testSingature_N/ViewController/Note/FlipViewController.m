//
//  FlipViewController.m
//  FlipViewTest
//
//  Created by Mac Pro on 6/6/12.
//  Copyright (c) Dawn(use for learn,base on CAShowcase demo). All rights reserved.
//

#import "FlipViewController.h"
#import "UIView+Screenshot.h"
@implementation FlipViewController
@synthesize backScrollView;
@synthesize flipDetailViewController;
@synthesize inScrollViewLayer;
@synthesize subNav;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        flipDetailViewController = [[FlipDetailViewController alloc]initWithNibName:@"FlipDetailViewController" bundle:nibBundleOrNil];
        flipDetailViewController.delegate = self;

        subNav = [[UINavigationController alloc]initWithRootViewController:flipDetailViewController];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleBordered target:self action:@selector(addANote:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    return self;
}
-(void)addANote:(id)sender{
    AddNewNoteViewController *addDetail = [[AddNewNoteViewController alloc]initWithNibName:@"AddNewNoteViewController" bundle:nil];
    addDetail.delegateForAdd = self;
    [self.navigationController pushViewController:addDetail animated:YES];
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
    UIView *myView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    myView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.view = myView;
    backScrollView = [[FlipScrollView alloc]initWithFrame:myView.frame];
    backScrollView.backgroundColor = [UIColor whiteColor];
    backScrollView.delegateForFlip = self;
    [self.view addSubview:backScrollView];
}
-(void)refreshFlipView{
    [backScrollView loadViewData];
}
-(void)refreshFlipViewForDelete{
    [backScrollView loadViewData];
}

- (void)viewWillAppear:(BOOL)animated
{

//    [backScrollView loadViewData];
}// Called when the view is about to made visible. Default does nothing

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.backScrollView = nil;
    self.flipDetailViewController = nil;
    self.inScrollViewLayer = nil;
    self.subNav = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - FlipScrollViewDelegate
//-(UIImage *)imageForDetailShowed:(FlipScrollView *)flipScroll atIndex:(NSInteger)index
//{
//    UIImage *image = ;
//	return image;
//}

-(void)flipScrollView:(FlipScrollView *)flipScroll didSelectAtIndex:(NSInteger)index withLayer:(CALayer *)layer
{
    self.inScrollViewLayer = (InScrollViewLayer *)layer;
    flipDetailViewController.indexNumber = index;
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    //?????????scrollview?????????layer??????????????????????????????????????????????????????layer??????????????????????????????????????????????????????layer?????????layer??????
    [self.navigationController.view.layer addSublayer:inScrollViewLayer];
    [CATransaction commit];
    
    //??????layer????????????????????????
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:self.inScrollViewLayer.frame];
    boundsAnimation.toValue = [NSValue valueWithCGRect:self.navigationController.view.bounds];
    //??????layer?????????
    CABasicAnimation *positonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positonAnimation.fromValue = [NSValue valueWithCGPoint:self.inScrollViewLayer.position];
    positonAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.navigationController.view.bounds), CGRectGetMidY(self.navigationController.view.bounds))];

   //????????????
    CAAnimationGroup *group =[CAAnimationGroup animation];
    group.duration = 0.5;
    group.animations = [NSArray arrayWithObjects:boundsAnimation,positonAnimation, nil];
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.inScrollViewLayer addAnimation:group forKey:@"zoomIn"];
    
    //????????????
    CATransition *transition = [CATransition animation];
    transition.type =@"flip";// kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 0.25;
    self.inScrollViewLayer.contents = (id)[subNav.view screenshot].CGImage;
    [self.inScrollViewLayer addAnimation:transition forKey:@"push"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	if (anim == [self.inScrollViewLayer animationForKey:@"zoomIn"]) {
		//self.transitionLayer.hidden = YES;
		[self.navigationController presentModalViewController:subNav animated:NO];
	}
}
#pragma mark - FlipDetailViewControllerDelegate
-(void)FlipDetailViewControllerClose:(FlipDetailViewController *)flipViewController
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [self.inScrollViewLayer removeAllAnimations];
    self.inScrollViewLayer.frame = self.navigationController.view.bounds;
    [CATransaction commit];
    [backScrollView performSelector:@selector(resetSelection) withObject:nil afterDelay:0.0];
    self.inScrollViewLayer = nil;
    [self dismissModalViewControllerAnimated:NO];
}

@end
