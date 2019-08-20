//
//  AppDelegate.m
//  LifeCycle
//
//  Created by Twisted Fate on 2019/8/15.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

// app启动完成就会调用  如果由通知打开,launchOptions对应的key有值, iOS10之后UNUserNotificationCenterDelegate中的didReceiveNotificationResponse方法也能响应
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"%s", __func__);
    

    return YES;
}

// 程序由后台转入前台
// 本地通知key: UIApplicationWillEnterForegroundNotification
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"%s", __func__);
    
}


// 程序进入活跃状态
// 本地通知key: UIApplicationDidBecomeActiveNotification
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"%s", __func__);
    
}

// 程序进入非活跃状态
// 比如有电话进来或者锁屏等情况, 此时应用会先进入非活跃状态, 也有可能是程序即将进入后台(进入后台前会先调用)
// 本地通知key: UIApplicationWillResignActiveNotification
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    NSLog(@"%s", __func__);
}

// 进入后台
// 本地通知key: UIApplicationDidEnterBackgroundNotification
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"%s", __func__);

}

// 程序即将退出
// UIApplicationWillTerminateNotification
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"%s", __func__);
}


@end
