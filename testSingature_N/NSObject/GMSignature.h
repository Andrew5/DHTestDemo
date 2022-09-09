//
//  GMSignature.h
//  GomeZk
//
//  Created by jabraknight on 2021/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMSignature : NSObject
///请求时入参
@property (nonatomic, strong)NSDictionary *queryDict;
///发起的 Post 请求的 Body 部分
@property (nonatomic, strong)NSData *HTTPBody;
///登录后的token
@property (nonatomic, strong)NSString *sessionToken;
@property (nonatomic, strong)NSString *userToken;
///sha256(orderByKey(queryString) + base64(body) + timestamp + nonce + signToken)
- (NSString *)queryString;
- (NSString *)requestBody;
- (NSString *)timeStamp;
- (NSString *)onceArc4random;
- (NSString *)sha256SignatureResult;
@end

NS_ASSUME_NONNULL_END
