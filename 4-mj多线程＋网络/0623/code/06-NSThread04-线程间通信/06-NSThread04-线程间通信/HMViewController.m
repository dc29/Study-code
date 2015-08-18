//
//  HMViewController.m
//  06-NSThread04-线程间通信
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 在子线程中调用download方法下载图片
    [self performSelectorInBackground:@selector(download) withObject:nil];
}

/**
 * 下载图片 : 子线程
 */
- (void)download
{
    // 1.根据URL下载图片
    NSURL *url = [NSURL URLWithString:@"http://news.baidu.com/z/resource/r/image/2014-06-22/2a1009253cf9fc7c97893a4f0fe3a7b1.jpg"];
    NSLog(@"-------begin");
    NSData *data = [NSData dataWithContentsOfURL:url]; // 这行会比较耗时
    NSLog(@"-------end");
    UIImage *image = [UIImage imageWithData:data];
    
    // 2.回到主线程显示图片（这就属于线程间的交互）
    // [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    
    
    // 解释： waitUntilDone:YES 是指等主线程执行完毕setimage， 子线程这段代码才算通过。
    // setImage: 1s
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
    // 在子线程做着做着想回到主线程.
    // [self performSelectorOnMainThread:@selector(settingImage:) withObject:image waitUntilDone:NO];
}




/**
 * 设置(显示)图片: 主线程
 */
//- (void)settingImage:(UIImage *)image
//{
//    self.imageView.image = image
//}
@end
