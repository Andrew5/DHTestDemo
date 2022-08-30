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

#import "TimeProfiler.h"
#import "TimeProfilerVC.h"
#import "TPCallTrace.h"
#import "TPMainVC.h"
#import "TPModel.h"
#import "TPRecordCell.h"
#import "TPRecordHierarchyModel.h"
#import "TPRecordModel.h"
#import "UIWindow+CallRecordShake.h"
#import "fishhook.h"

FOUNDATION_EXPORT double HHTimeProfilerVersionNumber;
FOUNDATION_EXPORT const unsigned char HHTimeProfilerVersionString[];

