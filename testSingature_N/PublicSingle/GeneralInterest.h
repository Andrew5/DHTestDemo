//
//  GeneralInterest.h
//  TestAPP
//
//  Created by 岳腾飞 on 2022/9/15.
//

#import <Foundation/Foundation.h>

#define kGI     [GeneralInterest shareInterest]
#define kGICOC(className) [[GeneralInterest shareInterest] objeWithClassName:className]
#define kGIDOC(className) [[GeneralInterest shareInterest] deallocWithClassName:className]

NS_ASSUME_NONNULL_BEGIN

@interface GeneralInterest : NSObject
+(instancetype)shareInterest;
-(id)objeWithClassName:(NSString *)className;
-(void)deallocWithClassName:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
