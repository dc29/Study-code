//
//  HMViewController.m
//  08-NSInvocationOperation（演示）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
#warning operation直接调用start，是同步执行（在当前线程执行操作）
//    [operation start];
    
    // 添加操作到队列中，会自动异步执行
    [queue addOperation:operation];
}

- (void)download
{
    NSLog(@"download-----%@", [NSThread currentThread]);
}

@end
