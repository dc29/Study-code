//
//  HMViewController.m
//  01-多线程01-阻塞主线程
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

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

- (IBAction)btnClick {
    // 1.获得当前的线程
    NSThread *current = [NSThread currentThread];
    
    // 2.执行一些耗时操作
    for (int i = 0; i<10000; i++) {
        // 3.输出线程
        NSLog(@"%@", current); // 在ios中， nslog是一个比较耗时的操作。
    }
}
@end
