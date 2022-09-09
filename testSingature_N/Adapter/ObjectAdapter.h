//
//  ObjectAdapter.h
//  testSingature
//
//  Created by jabraknight on 2021/12/31.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AdapteTargetObject.h"
#import "AdapteeObject.h"

NS_ASSUME_NONNULL_BEGIN

//对象适配器类
@interface ObjectAdapter : NSObject<TargetDelgate> {
    AdapteeObject         *_adaptee;
}

@end

NS_ASSUME_NONNULL_END
