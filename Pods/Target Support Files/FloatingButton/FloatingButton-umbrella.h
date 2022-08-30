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

#import "FLKeyWindowTracker.h"
#import "FloatingButton.h"
#import "FLPicker.h"
#import "NSObject+Picker.h"
#import "FLSandBoxHelper.h"
#import "ScreenHelper.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "FloatingWrapper.h"

FOUNDATION_EXPORT double FloatingButtonVersionNumber;
FOUNDATION_EXPORT const unsigned char FloatingButtonVersionString[];

