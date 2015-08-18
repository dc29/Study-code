//
//  HMViewController.m
//  01-URLSession-断点下载（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController () <NSURLSessionDownloadDelegate, NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)download:(UIButton *)sender;

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation HMViewController


// 只需要创建一次； 懒加载;
- (NSURLSession *)session
{
    if (!_session) {
        // 获得session
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        // 这个mainqueue是用来存放代理方法那些任务的; 
    }
    return _session;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)download:(UIButton *)sender {
    // 按钮状态取反
    sender.selected = !sender.isSelected;
    
    if (self.task == nil) { // 开始（继续）下载
        if (self.resumeData) { // 这个有值， 就是曾经下载暂停了， 所以要恢复
            [self resume];
        } else { // 开始
            [self start];
        }
    } else { // 暂停
        [self pause];
    }
}

/**
 *  从零开始
 */
- (void)start
{
    // 1.创建一个下载任务
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/resources/videos/minion_01.mp4"];
    self.task = [self.session downloadTaskWithURL:url];
    
    // 2.开始任务
    [self.task resume];
}

/**
 *  恢复（继续）
 */
- (void)resume
{
    // 传入上次暂停下载返回的数据，就可以恢复下载 ;resumedata包含了上次下载的url和位置
    // 再次赋值是为了下次再拿到他;
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    
    // 开始任务
    [self.task resume];
    
    // 清空
    self.resumeData = nil;
}

/**
 *  暂停
 */
// self ---> task ---> block ----> self;
- (void)pause
{
    // 暂停需要拿到这个任务;
    
    __weak typeof(self) vc = self;
    [self.task cancelByProducingResumeData:^(NSData *resumeData) {
        // 取消成功会来到这个block;
        //  resumeData : 包含了继续下载的开始位置\下载的url
        vc.resumeData = resumeData;
        vc.task = nil;
        
        // 任务取消了就不能再用了， 所以别让其在内存中存在了;
    }];
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [mgr moveItemAtPath:location.path toPath:file error:nil];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"获得下载进度--%@", [NSThread currentThread]);
    // 获得下载进度
    self.progressView.progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
//{
//
//}
//
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
//{
//
//}
@end
