//
//  DHMethodChange.h
//  testSingature
//
//  Created by jabraknight on 2021/9/14.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHMethodChange : NSObject {
        id   temp_delegate;
        SEL  onSuccessCallback;
        SEL  onFailureCallback;
}

- (void)passMethodwithBool:(BOOL)boolvalue
                 delegate:(id)requestDelegate
                onSuccess:(SEL)successCallback
                onFailure:(SEL)failureCallback;
@end

NS_ASSUME_NONNULL_END
