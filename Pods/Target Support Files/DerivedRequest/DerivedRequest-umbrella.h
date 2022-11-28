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

#import "BaseResponse.h"
#import "BaseSessionManager.h"
#import "BaseTask.h"
#import "GenericTask.h"

FOUNDATION_EXPORT double DerivedRequestVersionNumber;
FOUNDATION_EXPORT const unsigned char DerivedRequestVersionString[];

