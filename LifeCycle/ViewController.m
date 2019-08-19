//
//  ViewController.m
//  LifeCycle
//
//  Created by Twisted Fate on 2019/8/15.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "ViewController.h"
#import "TF_View.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *blueView;

@property (strong, nonatomic) IBOutlet UIView *garyView;

@end

@implementation ViewController

/**
 load方法:
 当类被引用进项目的时候就会执行load函数(在main函数开始执行之前）
 与这个类是否被用到无关, 每个类的load函数只会自动调用一次.
 由于load函数是系统自动加载的 不需要[super load], 否则会导致父类的load方法重复调用
 
 ### 注意:
        load调用时机比较早,当load调用时,其他类可能还没加载完成,运行环境不安全.
        load方法是线程安全的，它使用了锁，我们应该避免线程阻塞在load方法
 
 load方法加载顺序:
 
 1. 一个类的+load方法在其父类的+load方法后调用
 2. 一个Category的+load方法在被其扩展的类自由+load方法后调用, 当有多个类别(Category)都实现了load方法, 这几个load方法都会执行, 但执行顺序不确定(其执行顺序与类别在Compile Sources中出现的顺序一致)
 */
+ (void)load {
    
    NSLog(@"%s", __func__);

}

/**
 initialize方法:
 该方法在类或者子类的第一个方法被调用前调用, 即使类文件被引用进项目, 但是没有使用, initialize不会被调用
 initialize与load方法相同为系统自动调用, 无需[super initialize]
 
 initialize方法调用顺序:
 1. 父类的initialize方法会比子类的initialize方法先执行
 2. 当子类未实现initialize方法时, 会调用父类initialize方法, 子类实现initialize方法时,会覆盖父类initialize方法.
 3. 当有多个Category都实现了initialize方法,会覆盖类中的方法,只执行一个(会执行Compile Sources 列表中最后一个Category 的initialize方法)
*/
+ (void)initialize
{
    if (self == [ViewController class]) {
        NSLog(@"%s", __func__);
    }
}

// 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s", __func__);
    
    TF_View *tfView = [[TF_View alloc] initWithFrame:CGRectMake(100, 500, 128, 88)];
    tfView.backgroundColor = [UIColor redColor];
    tfView.tag = 1000;
    [self.view addSubview:tfView];
    
    self.blueView.userInteractionEnabled = YES;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.blueView addGestureRecognizer:pan];
    
}


- (void)panAction:(UIPanGestureRecognizer *)pan {

    UIView *view = [self.view viewWithTag:1000];
    view.frame = CGRectMake(0, 0, 44, 44);
    
    CGPoint point = [pan locationInView:pan.view];
    CGPoint fatherPoint = [self.view convertPoint:point fromView:pan.view];

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            NSLog(@"faterPoint == %@", NSStringFromCGPoint(fatherPoint));
            self.blueView.center = fatherPoint;
            
            break;
        default:
            break;
    }
}

// 视图即将出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

// 即将布局
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
  
    NSLog(@"%s", __func__);
}

//布局完毕
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s", __func__);
}


// 视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
}


// 视图即将消失
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    NSLog(@"%s", __func__);

}

// 视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s", __func__);

    
}

// 内存报警
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s", __func__);

}

@end
