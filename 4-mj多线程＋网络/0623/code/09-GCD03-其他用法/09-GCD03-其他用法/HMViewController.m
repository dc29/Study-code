//
//  HMViewController.m
//  09-GCD03-其他用法
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#define global_queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define main_queue dispatch_get_main_queue()

#import "HMViewController.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 图片1: http://news.baidu.com/z/resource/r/image/2014-06-22/2a1009253cf9fc7c97893a4f0fe3a7b1.jpg
    // 图片2: http://news.baidu.com/z/resource/r/image/2014-06-22/b2a9cfc88b7a56cfa59b8d09208fa1fb.jpg
    /**
     1.下载图片1和图片2
     
     2.将图片1和图片2合并成一张图片后显示到imageView上
     
     思考:
     * 下载图片 : 子线程
     * 等2张图片都下载完毕后, 才回到主线程
     */
}


#warning 这种放到两个队列中执行.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 创建一个组
    dispatch_group_t group = dispatch_group_create();
    
    // 开启一个任务下载图片1
    __block UIImage *image1 = nil;
    dispatch_group_async(group, global_queue, ^{
        image1 = [self imageWithURL:@"http://news.baidu.com/z/resource/r/image/2014-06-22/2a1009253cf9fc7c97893a4f0fe3a7b1.jpg"];
    });
    
    // 开启一个任务下载图片2
    __block UIImage *image2 = nil;
    dispatch_group_async(group, global_queue, ^{
        image2 = [self imageWithURL:@"http://news.baidu.com/z/resource/r/image/2014-06-22/b2a9cfc88b7a56cfa59b8d09208fa1fb.jpg"];
    });
    
    // 同时执行下载图片1\下载图片2操作
    
    // 等group中的所有任务都执行完毕, 再回到主线程执行其他操作
    dispatch_group_notify(group, main_queue, ^{
        self.imageView1.image = image1;
        self.imageView2.image = image2;
        
        // 合并
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        self.bigImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    });
    
// 这个只保证执行一次; 但是这么做有问题， 因为是对象方法， 再创建对象，又会打印;
//    if (self.log == NO) {
//        NSLog(@"-------touchesBegan");
//        self.log = YES;
//    }
    
#warning 只执行一次的代码; 单例用的就是这个，。 
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"-------touchesBegan");
//    });
}


#warning 这种比较笨， 两个放到一个队列中执行; 有效率问题
- (void)downlaod2image
{
    dispatch_async(global_queue, ^{
        NSLog(@"下载图片---%@", [NSThread currentThread]);
        
        // 下载图片1
        UIImage *image1 = [self imageWithURL:@"http://news.baidu.com/z/resource/r/image/2014-06-22/2a1009253cf9fc7c97893a4f0fe3a7b1.jpg"];
        NSLog(@"下载完图片1---%@", [NSThread currentThread]);
        
        // 下载图片2
        UIImage *image2 = [self imageWithURL:@"http://news.baidu.com/z/resource/r/image/2014-06-22/2a1009253cf9fc7c97893a4f0fe3a7b1.jpg"];
        NSLog(@"下载完图片2---%@", [NSThread currentThread]);
        
        dispatch_async(main_queue, ^{
            NSLog(@"显示图片---%@", [NSThread currentThread]);
            
            self.imageView1.image = image1;
            self.imageView2.image = image2;
            
            // 合并
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
            [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
            [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
            self.bigImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            // 关闭上下文
            UIGraphicsEndImageContext();
        });
    });
}


// 代码抽取出来。
- (UIImage *)imageWithURL:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url]; // 这行会比较耗时
    return [UIImage imageWithData:data];
}



- (void)delay
{
    //    NSLog(@"----touchesBegan----%@", [NSThread currentThread]);
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    //    });
    // 1.全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.计算任务执行的时间
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
    
    // 3.会在when这个时间点, 执行queue中的任务
    dispatch_after(when, queue, ^{
        NSLog(@"----run----%@", [NSThread currentThread]);
    });
}


//- (void)run
//{
//    NSLog(@"----run----%@", [NSThread currentThread]);
//}

@end
