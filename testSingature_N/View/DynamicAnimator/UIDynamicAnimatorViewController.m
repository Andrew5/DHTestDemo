//
//  UIDynamicAnimatorViewController.m
//  LocalNoticeAndBadge
//
//  Created by jabraknight on 2021/1/25.
//  Copyright © 2021 CBayel. All rights reserved.
//

#import "UIDynamicAnimatorViewController.h"
#import "BackView.h"

@interface UIDynamicAnimatorViewController () {
    UIDynamicAnimator     *_animator;    //物理仿真器
    UIGravityBehavior     *_gravity;     //重力行为
    UICollisionBehavior   *_collision;   //碰撞行为
    UISnapBehavior        *_snap;        //吸附（捕捉）行为
    UIAttachmentBehavior  *_attach;      //附着行为
    
    UIView              *_view1;
    UIView              *_view2;
    
    BackView            *_backView;    //用来作为仿真器视图容器范围
    CADisplayLink       *_link;
}
@property (nonatomic,assign)CGPoint startTouchPosition;
@end

@implementation UIDynamicAnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self AttachmentBehaviorfunc];
}
- (void)learnDynamicAnimator{
    // Do any additional setup after loading the view.
    UIView * apple = [[UIView alloc] initWithFrame:CGRectMake(40,40, 40, 40)];
    apple.backgroundColor = [UIColor redColor];
    [self.view addSubview:apple];
    ///初始化物理仿真器
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    /// 添加重力行为
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[apple]];
    /// //所有行为必须添加到仿真器中才能生效
    [_animator addBehavior:_gravity];
    //    _gravity.gravityDirection = CGVectorMake(0, -1);
    
    //添加碰撞行为
    _collision = [[UICollisionBehavior alloc] initWithItems:@[apple]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;         //边界检测
    [_animator addBehavior:_collision];
}

- (void)AttachmentBehaviorfunc{
    _backView = [[BackView alloc] initWithFrame:self.view.bounds];
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
    
    
    _backView.backgroundColor = [UIColor whiteColor];
    _view1.backgroundColor = [UIColor blueColor];
    _view1.layer.cornerRadius = 25.0;
    _view2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    
    
    [self.view addSubview:_backView];
    [_backView addSubview:_view1];
    [_backView addSubview:_view2];
    
    
    
    //初始化仿真器
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_backView];
    
    //添加重力行为
    _gravity = [[UIGravityBehavior alloc] initWithItems:nil];
    [_gravity addItem:_view2];
    
    // 添加碰撞行为
    _collision = [[UICollisionBehavior alloc] initWithItems:nil];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_collision addItem:_view1];
    [_collision addItem:_view2];
    
    //添加吸附行为（捕捉行为），意思是让物体吸附到某一点上
    _snap = [[UISnapBehavior alloc] initWithItem:_view1 snapToPoint:CGPointMake(125, 125)];
    _snap.damping = 1.0;
    
    //添加附着行为，让_view2视图附着在_view1周围（两物体附着的距离取决于它们的初始位置的距离）
    _attach = [[UIAttachmentBehavior alloc] initWithItem:_view1 attachedToItem:_view2];
    _attach.damping = 0.1;    //弹力
    _attach.frequency = 1.0;  //频率
    
    
    [_animator addBehavior:_gravity];
    [_animator addBehavior:_collision];
    [_animator addBehavior:_snap];
    [_animator addBehavior:_attach];
    
    //添加runloop便于绘制直线
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
//此方法会在程序绘制每帧时调用一次，再调用backView的drawRect方法绘制线条

-(void)update
{
    CGPoint p1 = _view1.center;
    [_backView setValue:@(p1) forKey:@"point1"];
    [_backView setValue:@(_view2.center) forKey:@"_point2"];
    //    [NSValue valueWithCGPoint:CGPointMake(0, 1)]
    //    NSLog(@"%@",[_backView valueForKey:@"_point1"]);
    //    id point1 = [_backView valueForKey:@"_point1"];
    //     [NSValue valueWithCGPoint:[point1   CGPointValue]];
    NSValue *avalue =[_backView valueForKey:@"point1"];
    CGPoint nd = [avalue   CGPointValue];
    NSLog(@"%f",nd.x);
    
    //    _backView.point1 = _view1.center;
    //    _backView.point2 = _view2.center;
    [_backView setNeedsDisplay];
}


///添加触摸创建
//屏幕触摸事件，利用吸附行为让圆形物体跟随用户手指移动
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    //获取点击点的坐标
    //    CGPoint point = [[touches anyObject] locationInView:self.view];
    //    //初始化一个视图参与运动，颜色随机
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //    view.center = point;
    //
    //
    //    CGRect frame = view.frame;
    //    frame.size.width = arc4random() % (128 - 50 + 1) + 50;
    //    frame.size.height = frame.size.width;
    //    view.frame = frame;
    //
    //    view.layer.cornerRadius = frame.size.width/2;
    //
    //    CGFloat red = arc4random()% 200 + 55;
    //    CGFloat green = arc4random()% 200 + 55;
    //    CGFloat blue = arc4random()% 200 + 55;
    //    view.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    //    [self.view addSubview:view];
    //
    //    //添加重力行为
    //    [_gravity addItem:view];
    //
    //    //添加碰撞行为
    //    [_collision addItem:view];
    
    
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    //要先移除原来的吸附行为， 不然物体无法运动
    [_animator removeBehavior:_snap];
    _snap = [[UISnapBehavior alloc] initWithItem:_view1 snapToPoint:pt];
    _snap.damping = 1.0;
    [_animator addBehavior:_snap];
    self.startTouchPosition = pt;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取当前触摸操作的位置坐标
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    [_animator removeBehavior:_snap];
    _snap = [[UISnapBehavior alloc] initWithItem:_view1 snapToPoint:pt];
    _snap.damping = 1.0;
    [_animator addBehavior:_snap];
    //    ///拖拽
    //    //获取上一个触摸点的位置坐标
    //    CGPoint prevloc = [[touches anyObject] previousLocationInView:self.view];
    //    CGRect myFrame = self.view.frame;
    //    //改变View的x、y坐标值
    //    float deltaX = pt.x - prevloc.x;
    //    float deltaY = pt.y - prevloc.y;
    //    myFrame.origin.x += deltaX;
    //    myFrame.origin.y += deltaY;
    //    //重新设置View的显示位置
    ////    [self setFrame:myFrame];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint currentTouchPosition = [aTouch locationInView:self.view];
    //  判断水平滑动的距离是否达到了设置的最小距离，并且是否是在接近直线的路线上滑动（y轴偏移量）
    //水平滑动最小间距 12
    //垂直方向最大偏移量 4
    if (fabs(self.startTouchPosition.x - currentTouchPosition.x) >= 12 &&
        fabs(self.startTouchPosition.y - currentTouchPosition.y) <= 4)
    {
        // 满足if条件则认为是一次成功的滑动事件，根据x坐标变化判断是左滑还是右滑
        if (self.startTouchPosition.x < currentTouchPosition.x) {
            //            [self rightSwipe];//右滑响应方法
            NSLog(@" 右滑响应方法 ");
        } else {
            //            [self leftSwipe];//左滑响应方法
            NSLog(@" 左滑响应方法 ");
        }
        //重置开始点坐标值
        self.startTouchPosition = CGPointZero;
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
