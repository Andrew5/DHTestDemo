//
//  GMSignature.m
//  GomeZk
//
//  Created by jabraknight on 2021/6/16.
//

#import "GMSignature.h"
#import <CommonCrypto/CommonHMAC.h>
@interface GMSignature()

@end
@implementation GMSignature

- (NSString *)queryString {
    NSArray *keyArray = self.queryDict.allKeys;
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *orderValueArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<sortArray.count; i++) {
        [self.queryDict objectForKey:sortArray[i]];
        NSString *result = [NSString stringWithFormat:@"%@=%@",sortArray[i],[self.queryDict objectForKey:sortArray[i]]];
        [orderValueArray addObject:result];
    }
    return [orderValueArray componentsJoinedByString:@"&"];
}

- (NSString *)requestBody {
    return [self.HTTPBody base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)timeStamp {
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

- (NSString *)onceArc4random {
    static int kNumber = 6;
    NSString *sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    NSMutableString *nonceStr = [[NSMutableString alloc] init];
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [nonceStr appendString:oneStr];
    }
    return nonceStr;
}

- (NSString *)share256HashWithContent:(NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return (NSMutableString *)[ret lowercaseString];;
}

- (NSString *)sha256SignatureResult {
    return [self share256HashWithContent:[NSString stringWithFormat:@"%@%@%@%@",[self requestBody],[self timeStamp],[self onceArc4random],self.sessionToken.length>0?self.sessionToken:self.userToken]];
}
@end
