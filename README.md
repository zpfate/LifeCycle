# LifeCycle
# iOS app启动流程与生命周期
## 启动流程
    1. 首先加载info.plist文件中的配置进行解析
    2. 创建沙盒, (iOS8之后会每次生成一个新的沙盒, 参考模拟器运行时的沙盒路径)
    3. 加载Mach-O可执行文件,读取dyld路径兵运行dyld动态链接器
        runtime就是在这个时候被初始化的, 同时还会加载c函数, Category以及C++静态函数, OC的+load方法, 最后dyld返回main函数地址, main函数被调用.
        

## +load以及+initialize
### load方法:
    当类被引用进项目的时候就会执行load函数(在main函数开始执行之前）
    与这个类是否被用到无关, 每个类的load函数只会自动调用一次.
    由于load函数是系统自动加载的 不需要[super load], 否则会导致父类的load方法重复调用

#### 注意:
    load调用时机比较早,当load调用时,其他类可能还没加载完成,运行环境不安全.
    load方法是线程安全的，它使用了锁，我们应该避免线程阻塞在load方法

load方法加载顺序:

    1. 一个类的+load方法在其父类的+load方法后调用
    2. 一个Category的+load方法在被其扩展的类自由+load方法后调用.
        当有多个类别(Category)都实现了load方法, 这几个load方法都会执行, 但执行顺序不确定(其执行顺序与类别在Compile Sources中出现的顺序一致)
    
###    initialize方法:
    该方法在类或者子类的第一个方法被调用前调用, 即使类文件被引用进项目, 但是没有使用, initialize不会被调用
    initialize与load方法相同为系统自动调用, 无需[super initialize]
    
initialize方法调用顺序:

    1. 父类的initialize方法会比子类的initialize方法先执行
    2. 当子类未实现initialize方法时, 会调用父类initialize方法. 
        子类实现initialize方法时, 会覆盖父类initialize方法.
    3. 当有多个Category都实现了initialize方法, 会覆盖类中的方法, 
        只执行一个(会执行Compile Sources列表中最后一个Category的initialize方法)

## main函数
    main函数是iOS程序的入口, 返回值为int, 死循环并不会返回.
    
![iOS main函数](https://user-gold-cdn.xitu.io/2019/8/20/16cadc1381735123?w=790&h=130&f=png&s=21512 "main函数" )

### UIApplicationMain:
    该方法会初始化一个UIApplication实例以及他的代理
    @param argc 参数个数
    @param argv 参数
    @param principalClassName 根据该参数初始化一个UIApplication或其子类的对象并开始接收事件(传入nil, 意味使用默认的UIApplication)
    @param delegateClassName 该参数指定AppDelegate类作为委托, delegate对象主要用于监听, 类似于生命周期的回调函数
    @return 返回值为int, 但是并不会返回(runloop), 会一直在内存中 直到程序终止

在swift工程中并没有main函数, 但是会发现`Appdelegate.swift`文件中有一句`@UIApplicationMain`,  这个标签的作用就是将标注的类作为委托, 创建一个`UIApplication`并启动整个程序. 如果我们想要使用`UIApplication`的子类可以直接删除这个标签, 并在工程中新建一个`main.swift`文件

![main.swift实现](https://user-gold-cdn.xitu.io/2019/8/20/16cadca151c63c61?w=700&h=231&f=png&s=44458 "main.swift实现")

## Appdelegate

### app启动完成
如果由通知打开, `launchOptions`对应的`key`有值, `iOS10`之后`UNUserNotificationCenterDelegate`中的`didReceiveNotificationResponse`方法也能响应
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%s", __func__);
    return YES;
}
```
### 程序由后台转入前台
前台是指app为当前手机展示. app首次启动时不会调用该方法
    本地通知key: UIApplicationWillEnterForegroundNotification
    
```
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"%s", __func__);
}
```

### 程序进入活跃状态
该方法app首次进入就会调用, 由后台转入前台, 也会在`applicationWillEnterForeground`方法之后调用
```
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%s", __func__);
}
```

### 程序进入非活跃状态
比如有电话进来或者锁屏等情况, 此时应用会先进入非活跃状态, 也有可能是程序即将进入后台(进入后台前会先调用)
    
    本地通知key: UIApplicationWillResignActiveNotification
    
```
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

    NSLog(@"%s", __func__);
}
```

### 程序进入后台
    本地通知key: UIApplicationDidEnterBackgroundNotification
```
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%s", __func__);
}
```

### 程序即将退出
    本地通知key: UIApplicationWillTerminateNotification

```
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%s", __func__);
}
```
