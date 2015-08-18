//
//  HMViewController.m
//  08-GCD02-下载图片
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


// 子线程下载， 下载完毕， 回主线程刷新界面。
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"--download--%@", [NSThread currentThread]);
        // 下载图片
        NSURL *url = [NSURL URLWithString:@"http://news.baidu.com/z/resource/r/image/2014-06-22/2a1009253cf9fc7c97893a4f0fe3a7b1.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url]; // 这行会比较耗时
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"--imageView--%@", [NSThread currentThread]);
            self.imageView.image = image;
        });
    });
}

@end
