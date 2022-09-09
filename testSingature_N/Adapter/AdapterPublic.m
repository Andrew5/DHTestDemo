//
//  AdapterPublic.m
//  testSingature
//
//  Created by jabraknight on 2021/12/31.
//  Copyright © 2021 zk. All rights reserved.
//

#import "AdapterPublic.h"

#import "AdapterObject.h"
#import "AdapteTargetObject.h"

@implementation AdapterPublic
- (void)targetMethod{
    //类适配器模式测试
    id<TargetDelgate> target = [[AdapterObject alloc] init];
    [target request];
}

@end
