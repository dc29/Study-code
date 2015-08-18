//
//  HMViewController.m
//  02-ASI01-基本使用（了解）
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "ASIHTTPRequest.h"

@interface HMViewController () // <ASIProgressDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, assign) BOOL downloading;
@property (nonatomic, strong) ASIHTTPRequest *request;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self download];
}

- (void)download
{
    if (self.downloading) {
        [self.request clearDelegatesAndCancel];
        
        self.downloading = NO;
    } else {
        // 1.URL
        NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/test.mp4"];
        
        // 2.创建一个请求对象
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        // 3.设置文件的缓存路径
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filepath = [caches stringByAppendingPathComponent:@"test.mp4"];
        request.downloadDestinationPath = filepath;
        
        // 4.设置进度监听的代理(要想成为进度监听代理，最好遵守ASIProgressDelegate协议)
        request.downloadProgressDelegate = self.progressView;
        
        // 这个属性设置为YES，就会支持断点下载
        request.allowResumeForFileDownloads = YES;
        
        // 如果要实现断点续传，需要设置一个文件的临时路径
        request.temporaryFileDownloadPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.temp"];
        
        // 5.开始请求
        [request startAsynchronous];
        self.request = request;
        
        self.downloading = YES;
    }
}

//- (void)setProgress:(float)newProgress
//{
////    NSLog(@"下载进度--%f", newProgress);
//    self.progressView.progress = newProgress;
//}
@end
