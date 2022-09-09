//
//  AdapterObject.h
//  testSingature
//
//  Created by jabraknight on 2021/12/31.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AdapteeObject.h"
#import "AdapteTargetObject.h"

NS_ASSUME_NONNULL_BEGIN
//类适配器类
//@interface AdapterObject : NSObject<TargetDelgate>
@interface AdapterObject : AdapteeObject<TargetDelgate>

@end

NS_ASSUME_NONNULL_END
