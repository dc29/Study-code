//
//  HMViewController.m
//  07-NSURLSession（掌握）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController () <NSURLSessionDownloadDelegate>

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// 任务：任何请求都是一个任务
// NSURLSessionDataTask : 普通的GET\POST请求
// NSURLSessionDownloadTask : 文件下载
// NSURLSessionUploadTask : 文件上传
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self downloadTask2];
}


// 这个可以监听下载进度， 需要称为代理;
- (void)downloadTask2
{
    // 需要成为代理， 需要用这个类; 是个配置;
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 1.得到session对象l 注意与下面方法的区别;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // 2.创建一个下载task
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/test.mp4"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    
    // 3.开始任务
    [task resume];
    
#warning 如果给下载任务设置了completionHandler这个block，也实现了下载的代理方法，优先执行block  ; 所以上面的代码把block删除了;
}

#pragma mark - NSURLSessionDownloadDelegate ; 三个方法必须都实现;
/**
 *  恢复下载时调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{

}


/**
 *  每当下载完（写完）一部分时就会调用（可能会被调用多次）
 *
 *  @param bytesWritten              这次调用写了多少
 *  @param totalBytesWritten         累计写了多少长度到沙盒中了
 *  @param totalBytesExpectedToWrite 文件的总长度
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"下载进度---%f", progress);
}

/**
 *  下载完毕后调用
 *
 *  @param location     临时文件的路径（下载好的文件）
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // location : 临时文件的路径（下载好的文件）
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [mgr moveItemAtPath:location.path toPath:file error:nil];
}






#pragma mark ------------------------------------------------------------------
/**
 *  下载任务：不能看到下载进度
 */
- (void)downloadTask
{
    // 1.得到session对象 ;
    // 也可以自己创建;
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 2.创建一个下载task
    // session中有一个概念“任务”， 任何请求都是一个任务;
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/test.mp4"];
#warning completionHandler是一口气， 但是他也是边下载边写沙盒， 他是写tmp中; 所以他也可以下载大文件;
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        // 下载完毕才到block这里;
        
        // location : 临时文件的路径（下载好的文件）
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
        NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
        
        // 将临时文件剪切或者复制Caches文件夹
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // AtPath : 剪切前的文件路径
        // ToPath : 剪切后的文件路径
        [mgr moveItemAtPath:location.path toPath:file error:nil];
    }];
    
    // 3.开始任务
    [task resume];
}


#warning 一般的get / post用这个
- (void)dataTask
{
    // 1.得到session对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 2.创建一个task，任务 ； 这么干是直接对一个url发get请求
    //    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    //    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //        NSLog(@"----%@", dict);
    //    }];
    
    
    // 下面是post请求; 需要设置请求体
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/login"];
    
    // 创建一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    // 设置请求体
    request.HTTPBody = [@"username=123&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"----%@", dict);
    }];
    
    // 3.开始任务
    [task resume];
}

@end
