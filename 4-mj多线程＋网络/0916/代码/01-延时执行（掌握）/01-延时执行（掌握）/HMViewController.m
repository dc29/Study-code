//
//  HMViewController.m
//  01-延时执行（掌握）
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"-----touchesBegan1-----");
    


    NSLog(@"-----touchesBegan2-----");
}

- (void)download:(NSString *)url
{
    NSLog(@"download------%@---%@", url, [NSThread currentThread]);
}

- (void)delay3
{
    // 3秒后回到主线程执行block中的代码
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
//        NSLog(@"------task------%@", [NSThread currentThread]);
//    });
    
    // 3秒后自动开启新线程 执行block中的代码
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"------task------%@", [NSThread currentThread]);
    });
}

- (void)delay2
{
    // 一旦定制好延迟任务后，不会卡主当前线程
    [self performSelector:@selector(download:) withObject:@"http://555.jpg" afterDelay:3];
}

- (void)delay1
{
    // 延迟执行不要用sleep，坏处：卡住当前线程
    [NSThread sleepForTimeInterval:3];
    NSLog(@"-----下载图片-----");
}

@end
