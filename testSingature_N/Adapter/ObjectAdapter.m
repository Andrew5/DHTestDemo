//
//  ObjectAdapter.m
//  testSingature
//
//  Created by jabraknight on 2021/12/31.
//  Copyright © 2021 zk. All rights reserved.
//

#import "ObjectAdapter.h"

@implementation ObjectAdapter

- (id)init {
    self = [super init];
    if (self != nil) {
        _adaptee = [[AdapteeObject alloc] init] ;
    }
    return self;
}

- (void)request {
    [_adaptee personEatFood];
}

@end
