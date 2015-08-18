//
//  ViewController.m
//  03-NSThread
//
//  Created by 周大伟 on 15/5/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSThread *thread; // 这种要清空， 暂时不考虑， 知道就行了。
- (IBAction)btnClick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    self.thread.name = @"thread - a";
}




- (IBAction)btnClick {
    


}

- (void) run
{
    // 1.
    NSLog(@"start --- %@", [NSThread currentThread].name);
    // 阻塞状态； 
    [NSThread sleepForTimeInterval:5.0];
    
    // 另一种方式
    // NSDate *date = [NSDate dateWithTimeIntervalSinceNow:2.0];
    // [NSThread sleepUntilDate:date];
    
    
    // 2.
    for (int i=0; i<1000; i++)
    {
        NSLog(@"run - %@ - %d", [NSThread currentThread].name, i);
        
        if(i == 50)
        {
            [NSThread exit]; // 或者直接return;
        }
    }
    
    
    // 3.
    NSLog(@"stop --- %@", [NSThread currentThread].name);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 开启线程
    [self.thread start];
}

@end

