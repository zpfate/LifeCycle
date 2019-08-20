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
    2. 一个Category的+load方法在被其扩展的类自由+load方法后调用, 当有多个类别(Category)都实现了load方法, 这几个load方法都会执行, 但执行顺序不确定(其执行顺序与类别在Compile Sources中出现的顺序一致)
    
###    initialize方法:
    该方法在类或者子类的第一个方法被调用前调用, 即使类文件被引用进项目, 但是没有使用, initialize不会被调用
    initialize与load方法相同为系统自动调用, 无需[super initialize]
    
initialize方法调用顺序:

    1. 父类的initialize方法会比子类的initialize方法先执行
    2. 当子类未实现initialize方法时, 会调用父类initialize方法, 子类实现initialize方法时,会覆盖父类initialize方法.
    3. 当有多个Category都实现了initialize方法,会覆盖类中的方法,只执行一个(会执行Compile Sources 列表中最后一个Category 的initialize方法)

