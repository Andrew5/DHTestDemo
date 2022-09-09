//
//  WKAutoDictionary.h
//  testSingature
//
//  Created by jabraknight on 2021/11/30.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKAutoDictionary : NSObject
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id opaqueObject;
@end

NS_ASSUME_NONNULL_END
