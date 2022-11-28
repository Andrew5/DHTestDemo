//
//  DHTouchVIew.m
//  TestDemo
//
//  Created by jabraknight on 2021/1/29.
//  Copyright © 2021 大海. All rights reserved.
//

#import "DHTouchVIew.h"
#import <objc/runtime.h>
@implementation DHTouchVIew
{
    BOOL pinchZoom;
    CGFloat previousDistance;
    CGFloat zoomFactor;
}
-(id)init
{
    self = [super init];
    if (self) {
        pinchZoom = NO;
        //缩放前两个触摸点间的距离
        previousDistance = 0.0f;
        zoomFactor = 1.0f;
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(event.allTouches.count == 2) {
        pinchZoom = YES;
        NSArray *touches = [event.allTouches allObjects];
        //接收两个手指的触摸操作
        CGPoint pointOne = [[touches objectAtIndex:0] locationInView:self];
        CGPoint pointTwo = [[touches objectAtIndex:1] locationInView:self];
        //计算出缩放前后两个手指间的距离绝对值（勾股定理）
        previousDistance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) +
                                pow(pointOne.y - pointTwo.y, 2.0f));
    } else {
        pinchZoom = NO;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(YES == pinchZoom && event.allTouches.count == 2) {
        NSArray *touches = [event.allTouches allObjects];
        CGPoint pointOne = [[touches objectAtIndex:0] locationInView:self];
        CGPoint pointTwo = [[touches objectAtIndex:1] locationInView:self];
        //两个手指移动过程中，两点之间距离
        CGFloat distance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) +
                                pow(pointOne.y - pointTwo.y, 2.0f));
        //换算出缩放比例
        zoomFactor += (distance - previousDistance) / previousDistance;
        zoomFactor = fabs(zoomFactor);
        previousDistance = distance;
        //缩放
        self.layer.transform = CATransform3DMakeScale(zoomFactor, zoomFactor, 1.0f);
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(event.allTouches.count != 2) {
        pinchZoom = NO;
        previousDistance = 0.0f;
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}


//获取类的属性
- (void)getPropertyList {
    //属性个数
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i =0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name =property_getName(property);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSLog(@"***属性名:%@", nameStr);
    }
    free(properties);
}

//获取类的成员变量
- (void)getIvarList {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i =0; i < count; i++) {
        NSString *nameStr = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        NSLog(@"***ivarName:%@", nameStr);
    }
    free(ivarList);
}

//获取一个类的实例方法列表
- (void)getInstanceMethodList {
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i =0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSLog(@"***实例方法名:%@",NSStringFromSelector(name));
    }
    free(methods);
}

//获取一个类的类方法列表
- (void)getClassMethodList {
    unsigned int count;
//    const char * class_name = class_getName([self class]);
//    Class metaClass = objc_getMetaClass(class_name);
    Method *methods = class_copyMethodList(object_getClass([self class]), &count);
    for (int i =0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSLog(@"***类方法名:%@",NSStringFromSelector(name));
    }
    free(methods);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
 1.如何访问类的私有成员变量,有两种方法:KVC和RunTime机制,我们可以通过上述类中的getIvarList方法来获取类的所有成员变量,经过和类的.h文件比较,如果不在.h文件中出现的则为其私有成员变量.这里我们拿name1这个私有成员变量来举例:
 通过RunTime来设置:
     HomeController *homeVC = [HomeController new];
     Ivar ivar = class_getInstanceVariable([homeVC class], [@"name1" UTF8String]);
     const char *ivarType = ivar_getTypeEncoding(ivar);
     NSLog(@"*** ivar type:%@", [[NSString alloc] initWithCString:ivarType encoding:NSUTF8StringEncoding]);
     
     object_setIvar(homeVC, ivar, @"pwf2006");
     NSString *ivarValue = object_getIvar(homeVC, ivar);
     NSLog(@"*** ivar value:%@", ivarValue);
     输出结果如下:
      2016-08-19 22:31:58.240 FirstGit[18695:7136558] *** ivar type:@"NSString"
      2016-08-19 22:31:58.240 FirstGit[18695:7136558] *** ivar value:pwf2006
 通过KVC来设置:
     [homeVC setValue:@"pwf2007"forKey:@"name1"];
     NSLog(@"*** ivar value:%@", [homeVCvalueForKey:@"name1"]);
     输出结果如下:
      2016-08-19 22:31:58.241 FirstGit[18695:7136558] *** ivar value:pwf2007
 2.通过getInstanceMethodList方法我们可以获取类实例的所有方法,包括私有的方法,我们拿privateMethod来进行举例:
     objc_msgSend(homeVC,@selector(privateMethod));
     输出结果如下:
      2016-08-19 22:31:58.241 FirstGit[18695:7136558] *** private instance methods
    通过getClassMethodList获取一个类的类方法列表,包括私有的类方法,我们拿classMethod这个类方法举例:
 objc_msgSend([homeVCclass],@selector(classMethod));
 输出结果如下:
 2016-08-19 22:31:58.241 FirstGit[18695:7136558] *** private class methods
 */
@end
