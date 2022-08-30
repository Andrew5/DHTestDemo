//
//  DHOutOfMemoryManager.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import "DHOutOfMemoryManager.h"
#import <UIKit/UIKit.h>

//#import "fishhook.h"
#import "hook.h"
#import <mach/mach.h>
#include <sys/stat.h>

static NSString *DHOOMPreviousBundleVersionKey = @"DHOOMPreviousBundleVersionKey";
static NSString *DHOOMAppWasTerminatedKey = @"DHOOMAppWasTerminatedKey";
static NSString *DHOOMAppWasInBackgroundKey = @"DHOOMAppWasInBackgroundKey";
static NSString *DHOOMAppDidCrashKey = @"DHOOMAppDidCrashKey";
static NSString *DHOOMAppWasExitKey = @"DHOOMAppWasExitKey";
static NSString *DHOOMPreviousOSVersionKey = @"DHOOMPreviousOSVersionKey";
static     char *intentionalQuitPathname;

@interface DHOutOfMemoryManager ()

- (void)appDidExit;

@end

static void (*_orig_exit)(int);
static void (*orig_exit)(int);
static void (*orig_abort)(void);

void my_exit(int value) {
    [[DHOutOfMemoryManager sharedInstance] appDidExit];
    orig_exit(value);
}

void _my_exit(int value) {
    [[DHOutOfMemoryManager sharedInstance] appDidExit];
    _orig_exit(value);
}

void my_abort(void) {
    [[DHOutOfMemoryManager sharedInstance] appDidExit];
    orig_abort();
}

@implementation DHOutOfMemoryManager

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
//      rebind_symbols((struct rebinding[1]){
//          {"_exit", (void *)_my_exit, (void *)&_orig_exit}
//      }, 1);
//      rebind_symbols((struct rebinding[1]){
//          {"exit", (void *)my_exit, (void **)&orig_exit}
//      }, 1);
//      rebind_symbols((struct rebinding[1]){
//          {"abort", (void *)my_abort, (void **)&orig_abort}
//      }, 1);
  });
}

- (void)beginMonitoringMemoryEventsWithHandler:(DHOutOfMemoryEventHandler)handler {
    
    [[DHOutOfMemoryManager sharedInstance] beginApplicationMonitoring];
    signal(SIGABRT, DHIntentionalQuitHandler);
    signal(SIGQUIT, DHIntentionalQuitHandler);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // Set up the static path for intentional aborts
    if ([DHOutOfMemoryManager intentionalQuitPathname]) {
        intentionalQuitPathname = strdup([DHOutOfMemoryManager intentionalQuitPathname]);
    }

    BOOL didIntentionallyQuit = NO;
    struct stat statbuffer;
    if (stat(intentionalQuitPathname, &statbuffer) == 0){
        // A file exists at the path, we had an intentional quit
        didIntentionallyQuit = YES;
    }
    BOOL didCrash = [defaults boolForKey:DHOOMAppDidCrashKey];;
    BOOL didTerminate = [defaults boolForKey:DHOOMAppWasTerminatedKey];
    BOOL didExit = [defaults boolForKey:DHOOMAppWasExitKey];
    // 获取当前OSVersion并取出上次存储的OSVersion进行对比
    BOOL didUpgradeApp = ![[DHOutOfMemoryManager currentBundleVersion] isEqualToString:[DHOutOfMemoryManager previousBundleVersion]];
    BOOL didUpgradeOS = ![[DHOutOfMemoryManager currentOSVersion] isEqualToString:[DHOutOfMemoryManager previousOSVersion]];
    if (!(didIntentionallyQuit || didCrash || didExit || didTerminate || didUpgradeApp || didUpgradeOS)) {
        if (handler) {
            BOOL wasInBackground = [[NSUserDefaults standardUserDefaults] boolForKey:DHOOMAppWasInBackgroundKey];
            handler(!wasInBackground);
        }
    }

    [defaults setObject:[DHOutOfMemoryManager currentBundleVersion] forKey:DHOOMPreviousBundleVersionKey];
    [defaults setObject:[DHOutOfMemoryManager currentOSVersion] forKey:DHOOMPreviousOSVersionKey];
    [defaults setBool:NO forKey:DHOOMAppWasTerminatedKey];
    [defaults setBool:NO forKey:DHOOMAppWasInBackgroundKey];
    [defaults setBool:NO forKey:DHOOMAppDidCrashKey];
    [defaults setBool:NO forKey:DHOOMAppWasExitKey];
    [defaults synchronize];
    // Remove intentional quit file
    unlink(intentionalQuitPathname);
}

#pragma mark termination_backgrounding

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DHOutOfMemoryManager alloc] init];
    });
    return sharedInstance;
}

- (void)beginApplicationMonitoring {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DHOOMAppWasTerminatedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DHOOMAppWasInBackgroundKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:DHOOMAppWasInBackgroundKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)appDidExit {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DHOOMAppWasExitKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)appDidCrash {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DHOOMAppDidCrashKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark app_version

+ (NSString *)currentBundleVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = infoDictionary[@"CFBundleShortVersionString"];
    NSString *minorVersion = infoDictionary[@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@.%@", majorVersion, minorVersion];
}

+ (NSString *)previousBundleVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:DHOOMPreviousBundleVersionKey];
}

#pragma mark OS_version

+ (NSString *)stringFromOperatingSystemVersion:(NSOperatingSystemVersion)version {
    return [NSString stringWithFormat:@"%@.%@.%@", @(version.majorVersion), @(version.minorVersion), @(version.patchVersion)];
}

+ (NSString *)currentOSVersion {
    return [self stringFromOperatingSystemVersion:[[NSProcessInfo processInfo] operatingSystemVersion]];
}

+ (NSString *)previousOSVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:DHOOMPreviousOSVersionKey];
}

#pragma mark crash_reporting

static void DHIntentionalQuitHandler(int signal) {
    creat(intentionalQuitPathname, S_IREAD | S_IWRITE);
}

#pragma mark crash_Path

+ (const char *)intentionalQuitPathname {
    NSString *appSupportDirectory = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
    if (![[NSFileManager defaultManager] fileExistsAtPath:appSupportDirectory isDirectory:NULL]) {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:appSupportDirectory withIntermediateDirectories:YES attributes:nil error:nil]) {
            return 0;
        }
    }
    NSString *fileName = [appSupportDirectory stringByAppendingPathComponent:@"intentionalquit"];
    return [fileName UTF8String];
}


@end
