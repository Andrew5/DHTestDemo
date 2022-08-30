#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TKPermissionKit.h"
#import "TKPermissionBluetooth.h"
#import "TKPermissionCalendar.h"
#import "TKPermissionCamera.h"
#import "TKPermissionContacts.h"
#import "TKPermissionFolders.h"
#import "TKPermissionHealth.h"
#import "TKPermissionHome.h"
#import "TKPermissionLocationAlways.h"
#import "TKPermissionLocationWhen.h"
#import "TKPermissionMedia.h"
#import "TKPermissionMicrophone.h"
#import "TKPermissionMotion.h"
#import "TKPermissionNetWork.h"
#import "TKPermissionNotification.h"
#import "TKPermissionPhoto.h"
#import "TKPermissionPublic.h"
#import "TKPermissionReminder.h"
#import "TKPermissionSiri.h"
#import "TKPermissionSpeech.h"
#import "TKPermissionTracking.h"

FOUNDATION_EXPORT double TKPermissionKitVersionNumber;
FOUNDATION_EXPORT const unsigned char TKPermissionKitVersionString[];

