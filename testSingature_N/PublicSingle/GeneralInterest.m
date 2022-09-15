//
//  GeneralInterest.m
//  TestAPP
//
//  Created by 岳腾飞 on 2022/9/15.
//

#import "GeneralInterest.h"

static GeneralInterest *_interest = nil;

@interface GeneralInterest ()
@property (strong, nonatomic) NSMutableDictionary* memObjs;
@end

@implementation GeneralInterest
+(instancetype)shareInterest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _interest = [[GeneralInterest alloc] init];
    });
    return _interest;
}
-(instancetype)init{
    self = [super init];
    if(self){
        _memObjs = @{}.mutableCopy;
    }
    return self;
}
-(id)objeWithClassName:(NSString *)className{
    if(className.length<=0) return nil;
    if([self.memObjs.allKeys containsObject:className]){
        return [self.memObjs objectForKey:className];
    }else{
        Class cls = NSClassFromString(className);
        NSObject *obj = [[cls alloc] init];
        [self.memObjs setObject:obj forKey:className];
        return obj;
    }
}
-(void)deallocWithClassName:(NSString *)className{
    if(className.length<=0) return;
    if([self.memObjs.allKeys containsObject:className]){
        [self.memObjs removeObjectForKey:className];
    }
}
@end
