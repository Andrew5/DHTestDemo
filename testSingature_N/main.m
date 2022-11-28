//
//  main.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <stdio.h>

struct {
    char y;
    char x;
    int z;
}s;
/*
 struct{int, char ,char}a
 ----|               ----| char                  ----| char
 ____|               ____|                       ____| char
 ____ >4字节 int      ____ >4字节 int              ____ >4字节 int
 ____|               ____|                       ____|
 ----|               ----|                       ----|
                     
 ----|               ____|                       ____|
 ____|               ____|                       ____|
 ____ >4字节 int      ____ >4字节 int              ____ >4字节 int
 ____|               ____|                       ____|
 ----|               ----|                       ----|
 
                          char
                         >4字节 int
 
 */
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        
        printf("内存对齐 %lu\n",sizeof(s));
       
        
        __block int sum = 0;
        int (^myBlocks)(int a, int b) = ^(int a, int b) {
            sum = a+b;
            return 5;
        };
        
        NSLog(@"输出--%d",myBlocks(10,20));
        NSLog(@"输出--%d",sum);
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
