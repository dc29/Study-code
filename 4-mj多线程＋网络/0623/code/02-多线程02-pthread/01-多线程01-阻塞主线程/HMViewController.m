//
//  HMViewController.m
//  01-多线程01-阻塞主线程
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
// 进入头文件看下， 项目上面显示这个文件是在/usr下面， 这里面一般都是比较nb的库。
#import <pthread.h>

@interface HMViewController ()
- (IBAction)btnClick;

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 返回值是void *, 接收一个void *参数
void *run(void *data) {
    
    NSThread *current = [NSThread currentThread];
    
    for (int i = 0; i<20000; i++) {
        NSLog(@"run---%@", current);
    }
    
    return NULL;
}

- (IBAction)btnClick {
    // 1.获得当前的线程
    NSThread *current = [NSThread currentThread];
    NSLog(@"btnClick---%@", current);
    
    // 2.执行一些耗时操作 : 创建一条子线程
    pthread_t threadId; // 一个pthread_t就代表一个线程id。
    pthread_create(&threadId, NULL, run, NULL); // 这行执行完，线程id就有值了， 一开始执行就调用run方法。
    
    // 线程id, 线程属性（一般不需要），指向函数的指针， 后面一般也不需要。
    //    pthread_create(<#pthread_t *restrict#>, <#const pthread_attr_t *restrict#>, <#void *(*)(void *)#>, <#void *restrict#>)
}
@end
