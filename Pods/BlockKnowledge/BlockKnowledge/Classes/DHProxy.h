//
//  DHProxy.h
//  DHBasicKnowledge
//
//  Created by jabraknight on 2022/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHProxy : NSProxy
@property(nonatomic, weak, readonly) NSObject *objc;

- (id)transformObjc:(NSObject *)objc;
+ (instancetype)proxyWithObjc:(id)objc;

@end

NS_ASSUME_NONNULL_END
