//
//  HMViewController.m
//  07-GCD01-基本使用
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(test) withObject:nil];
    
//    [self syncMainQueue];
}

- (void)test
{
    NSLog(@"test --- %@", [NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"任务 --- %@", [NSThread currentThread]);
    });
}

/**
 * 使用dispatch_async异步函数, 在主线程中往主队列中添加任务
 */
- (void)asyncMainQueue
{
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加任务到队列中 执行 ； 异步的意思是可以等会再执行， 不一定会开线程;
    dispatch_async(queue, ^{
        NSLog(@"----下载图片1-----%@", [NSThread currentThread]);
    });
}

/**
 * 使用dispatch_sync同步函数, 在主线程中往主队列中添加任务 : 任务无法往下执行
 */
#warning 注意下面这么干， 我等你， 你等我， 是死锁。 千万不能写， 千万不能在主线程中使用sync。
- (void)syncMainQueue
{
    // 1.获得主队列 ; 也是串行队列.
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加任务到队列中 执行
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片1-----%@", [NSThread currentThread]);
    });
//    dispatch_sync(queue, ^{
//        NSLog(@"----下载图片2-----%@", [NSThread currentThread]);
//    });
//    dispatch_sync(queue, ^{
//        NSLog(@"----下载图片3-----%@", [NSThread currentThread]);
//    });
    
    // 不会开启新的线程, 所有任务在主线程中执行
}

// 凡是函数名种带有create\copy\new\retain等字眼, 都需要在不需要使用这个数据的时候进行release
// GCD的数据类型在ARC环境下不需要再做release
// CF(Core Foundation)的数据类型在ARC环境下还是需要再做release

/**
 * 用dispatch_sync同步函数往串行列中添加任务
 */
- (void)syncSerialQueue
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", NULL);
    
    // 2.添加任务到队列中 执行
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 3.释放资源（arc中不用管他）
    // dispatch_release(queue);   // MRC(非ARC)
    
    // 总结: 不会开启新的线程
}

/**
 * 用dispatch_sync同步函数往并发队列中添加任务
 */
- (void)syncGlobalQueue
{
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.添加任务到队列中 执行
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 总结: 不会开启新的线程, 并发队列失去了并发的功能 ; 不开新线程就没办法并发了。
}

/**
 * 用dispatch_async异步函数往串行队列中添加任务
 */
- (void)asyncSerialQueue
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", NULL);
    
    // 2.添加任务到队列中 执行
    dispatch_async(queue, ^{
        NSLog(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 总结: 只开1个线程执行任务 ; 能开线程是因为是异步， 只开一个是因为是“串行”
}

/**
 * 用dispatch_async异步函数往并发队列中添加任务; 才能并发执行.
 */
- (void)asyncGlobalQueue
{
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.添加任务到队列中 执行
    dispatch_async(queue, ^{
        NSLog(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 总结: 同时开启了3个线程
}

@end
