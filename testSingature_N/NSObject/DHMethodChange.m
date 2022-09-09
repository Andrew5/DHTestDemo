//
//  DHMethodChange.m
//  testSingature
//
//  Created by jabraknight on 2021/9/14.
//  Copyright © 2021 zk. All rights reserved.
//

#import "DHMethodChange.h"

@implementation DHMethodChange
- (void)passMethodwithBool:(BOOL) boolvalue
                 delegate:(id)requestDelegate
                onSuccess:(SEL)successCallback
                onFailure:(SEL)failureCallback {
    temp_delegate = requestDelegate;
    onSuccessCallback = successCallback;
    onFailureCallback = failureCallback;
    //boolvalue仅仅是自定义的假设判断值。yes假设回调method1 ,no假设回调method2
    if (boolvalue) {
        [self method1];
    } else {
        [self method2];
    }
}

- (void)method1 {
    if([temp_delegate respondsToSelector:onSuccessCallback]){
        [temp_delegate performSelector:onSuccessCallback withObject:@"returnSUCCESSvalue"];
    }
}

- (void)method2 {
    if([temp_delegate respondsToSelector:onFailureCallback]){
        [temp_delegate performSelector:onFailureCallback withObject:@"returnFailedvalue"];
    }
}

@end
