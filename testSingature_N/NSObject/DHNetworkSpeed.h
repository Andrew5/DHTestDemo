//
//  DHNetworkSpeed.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const NetworkDownloadSpeedNotificationKey;

extern NSString *const NetworkUploadSpeedNotificationKey;

extern NSString *const NetworkSpeedNotificationKey;

@interface DHNetworkSpeed : NSObject

@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;

@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;

- (void)startNetworkSpeedMonitor;

- (void)stopNetworkSpeedMonitor;

- (void)checkDeviceInfo;
@end

NS_ASSUME_NONNULL_END
