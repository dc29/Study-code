//
//  HMViewController.m
//  05-NSThread03-线程同步
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()
/** 剩余票数 */
@property (nonatomic, assign) int leftTicketsCount;
@property (nonatomic, strong) NSThread *thread0;
@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 默认有100张
    self.leftTicketsCount = 100;
    
    // 开启多条线程同时卖票
    self.thread0 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread0.name = @"售票员 A";
//    self.thread0.threadPriority = 0.0;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread1.name = @"售票员 B";
//    self.thread1.threadPriority = 1.0;
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread2.name = @"售票员 C";
//    self.thread2.threadPriority = 0.0;
}

/**
 * 卖票
 */

// 加锁的方式有好几种;
/*
 
 1. nslock
 2. oc中加锁锁的是代码；让同一时间只有一个线程可以读取这段代码.
 */
- (void)saleTicket
{
    while (1) {
#warning 一份代码职能用一把锁/
        @synchronized(self) { // 加锁(只能用一把锁) // 没有提示， 因为苹果不推荐使用， 性能差， 但是有时候没办法;
            // 1.先检查票数
            int count = self.leftTicketsCount;
            if (count > 0) {
                // 暂停
//                [NSThread sleepForTimeInterval:0.0002];
                
                // 2.票数 - 1
                self.leftTicketsCount = count - 1;
                
                NSThread *current = [NSThread currentThread];
                NSLog(@"%@ 卖了一张票, 剩余%d张票", current.name, self.leftTicketsCount);
            } else {
                // 退出线程
                [NSThread exit];
            }
        } // 括号位置代表解锁
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.thread0 start];
    [self.thread1 start];
    [self.thread2 start];
}

@end
