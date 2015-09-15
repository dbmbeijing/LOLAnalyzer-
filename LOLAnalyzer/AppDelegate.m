//
//  AppDelegate.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigHeader.h"
#import <FIR/FIR.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //请把你从官网申请的appid和secretkey替换到这里再测试。
    //否则会提示错误
    NSString *appid = @"5cc3df8fea89facb";
    NSString *secretId = @"b2681a68ba17d23b";
    [NewWorldSpt initQQWDeveloperParams:appid QQ_SecretId:secretId];
    //可选方法,默认不写这个方法（本方法为了解决广告界面的点击失效问题）
    [NewWorldSpt setWindow:[UIApplication sharedApplication].delegate.window];
    //使用前先初始化一下插屏
    [NewWorldSpt initQQWDeveLoper:kTypePortrait];//填上你对应的横竖屏模式
    // Override point for customization after application launch.
    NSString*hdBug = @"1ab3202fa0c39ebb738d95777398e6dd";
    [FIR handleCrashWithKey:hdBug];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
