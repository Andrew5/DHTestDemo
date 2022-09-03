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
#import <os/proc.h>
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
/// 获取当前app占用内存量
+ (NSInteger)useMemoryForApp {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS)
    {
        int64_t memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        return (NSInteger)(memoryUsageInByte/1024/1024);
    }
    else
    {
        return -1;
    }
}
/// 设备总内存
+ (NSInteger)totalMemoryForDevice {
    return (NSInteger)([NSProcessInfo processInfo].physicalMemory/1024/1024);
}
/// 获取app当前可用的内存
+ (NSInteger)availableSizeOfMemory {
    if (@available(iOS 13.0, *)) {
        return (NSInteger)(os_proc_available_memory() / 1024.0 / 1024.0);
    }
    return 0;
}
/// 结合可用内存和已用内存计算出app总共可使用的内存
+ (NSInteger)limitSizeOfMemory {
    if (@available(iOS 13.0, *)) {
        task_vm_info_data_t taskInfo;
        mach_msg_type_number_t infoCount = TASK_VM_INFO_COUNT;
        kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&taskInfo, &infoCount);
 
        if (kernReturn != KERN_SUCCESS) {
            return 0;
        }
        return (NSInteger)((taskInfo.phys_footprint + os_proc_available_memory()) / 1024.0 / 1024.0);
    } else {
        NSInteger totalMemory = [DHOutOfMemoryManager totalMemoryForDevice];
        NSInteger limitMemory;
        if (totalMemory <= 1024) {
            limitMemory = totalMemory * 0.45;
        } else if (totalMemory >= 1024 && totalMemory <= 2048) {
            limitMemory = totalMemory * 0.45;
        } else if (totalMemory >= 2048 && totalMemory <= 3072) {
            limitMemory = totalMemory * 0.50;
        } else {
            limitMemory = totalMemory * 0.55;
        }
        return limitMemory;
    }
}
/// 获取CPU使用率
+ (CGFloat)cpuUsageForApp {
    kern_return_t kr;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    thread_basic_info_t basic_info_th;
    
    // get threads in the task
    //  获取当前进程中 线程列表
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS)
        return -1;

    float tot_cpu = 0;
    
    for (int j = 0; j < thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        //获取每一个线程信息
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS)
            return -1;
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            // cpu_usage : Scaled cpu usage percentage. The scale factor is TH_USAGE_SCALE.
            //宏定义TH_USAGE_SCALE返回CPU处理总频率：
            tot_cpu += basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
        
    } // for each thread
    
    // 注意方法最后要调用 vm_deallocate，防止出现内存泄漏
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    if (tot_cpu < 0) {
        tot_cpu = 0.;
    }
    
    return tot_cpu;
}

/// 获取某一条文件路径的文件大小
- (void)getFileSizeWithPath:(NSString *)path {
    NSInteger fileSize = 0;
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist){
        if(isDir){
            //文件夹
            NSArray *dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSLog(@"文件夹个数是 - %ld",dirArray.count);
            NSString *subPath = nil;
            for(NSString *str in dirArray) {
                subPath = [path stringByAppendingPathComponent:str];
                NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:subPath error:nil];
                NSInteger size = [dict[@"NSFileSize"] integerValue];
                NSLog(@"文件夹大小为 - %ld",size);
                [self getFileSizeWithPath:subPath];
            }
        } else {
            //文件
            NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            NSInteger size = [dict[@"NSFileSize"] integerValue];
            fileSize += size;
            NSLog(@"文件大小为 - %ld",fileSize);
        }
    }else{
        //不存在该文件path
        NSLog(@"不存在该文件");
    }
}

/// 删除本地缓存
+ (void)clearLocalDatas {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *homePath = NSHomeDirectory();
        NSArray *folders = @[@"Documents", @"Library", @"tmp"];
        for (NSString *folder in folders) {
            [DHOutOfMemoryManager clearFileWithPath:[homePath stringByAppendingPathComponent:folder]];
        }
    });
}

/// 删除某一路径下的所有文件
+ (void)clearFileWithPath:(NSString *)path {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *files = [fm subpathsAtPath:path];
    for (NSString *file in files) {
        NSError *error;
        NSString *filePath = [path stringByAppendingPathComponent:file];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (!error) {
                NSLog(@"remove file: %@", file);
            }
        }
    }
}
+ (void)放弃方法 {
    NSLog(@"放弃");
}
@end
