//
//  main.m
//  LifeCycle
//
//  Created by Twisted Fate on 2019/8/15.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// C语言程序入口

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


/**
 UIApplicationMain:
 该方法会初始化一个UIApplication实例以及他的代理
 
 @param argc 参数个数
 @param argv 参数
 @param principalClassName 根据该参数初始化一个UIApplication或其子类的对象并开始接收事件(传入nil, 意味使用默认的UIApplication)
 @param delegateClassName 该参数指定AppDelegate类作为委托, delegate对象主要用于监听, 类似于生命周期的回调函数
 @return 返回值为int, 但是并不会返回(runloop), 会一直在内存中 直到程序终止
 */
