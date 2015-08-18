//
//  ViewController.m
//  03-NSThread
//
//  Created by 周大伟 on 15/5/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)btnClick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick {
    
    // 1. 获得当前的线程
    NSThread *current = [NSThread currentThread];
    NSLog(@"btnClick -- %@", current);
    
    // 2. 执行耗时操作， 创建一条子线程 ; object参数传递给run
    [self threadCreate3];

}


- (void) run:(NSString *)param
{

    // [NSThread isMainThread];
    // [NSThread mainThread]; 获得主线程
    
    for (int i=0; i<20000; i++)
    {
        NSLog(@" run -- %@ -- %@", param, [NSThread currentThread]);
    }
}




/**
 *  创建线程的一种方法
 *  1. 先创建初始化线程
 *  2. 再开启
 */
- (void) threadCreate1
{
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"a"];
    thread1.name = @"thread - a";
    // 开启线程
    [thread1 start];
    
    
    // 再来一条
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"b"];
    thread2.name = @"thread - b";
    // 开启线程
    [thread2 start];
}


/**
 *  创建线程的第二种方法: 创建后自动自动
 */
- (void) threadCreate2
{
    // 这种有缺点， 不能一开始就拿到线程对象， 比如设置名称之类的； 这个方法没有返回值。
    // 线程名称一般是程序员用来调试的。 
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"a"];
}

/**
 *  第三种： 隐式创建， 也是自动启动
 */
- (void) threadCreate3
{
    // 任何对象都可以调这个方法，
    // 在后台执行 ＝＝ 在子线程
    [self performSelectorInBackground:@selector(run:) withObject:@"c"];
}
@end











