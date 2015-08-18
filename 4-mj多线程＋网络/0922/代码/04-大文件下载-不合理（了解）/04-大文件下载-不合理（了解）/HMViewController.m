//
//  HMViewController.m
//  04-大文件下载-不合理（了解）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "DACircularProgressView.h"

@interface HMViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

// 需要是可变的;
@property (nonatomic, strong) NSMutableData *fileData;

/**
 *  文件的总长度
 */
@property (nonatomic, assign) long long totalLength;

@property (nonatomic, weak) DACircularProgressView *circleView;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DACircularProgressView *circleView = [[DACircularProgressView alloc] init];
    circleView.frame = CGRectMake(100, 50, 100, 100);
    circleView.progressTintColor = [UIColor redColor];
    circleView.trackTintColor = [UIColor blueColor];
    circleView.progress = 0.01; // 进度值一开始就是满的，所以这里设置一下
    [self.view addSubview:circleView];
    self.circleView = circleView;
}

- (void)download
{
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    
    // 2.请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

#warning 这句代码一调， 会自动发请求; 代理用来监听下载进度的;
    // 3.下载(创建完conn对象后，会自动发起一个异步请求)
    [NSURLConnection connectionWithRequest:request delegate:self];
    
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES]; // 写yes就立即开始下载了;
    
    
    // 写no就是仅仅创建了连接， 不会发请求， 必须start才会发请求
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//    [conn start];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self download];
}

#pragma mark - NSURLConnectionDataDelegate代理方法
/**
 *  请求失败时调用（请求超时、网络异常）
 *
 *  @param error      错误原因
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}

/**
 *  1.接收到服务器的响应就会调用
 *
 *  @param response   响应
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    
    // 初始化数据
    self.fileData = [NSMutableData data];
    
    // 取出文件的总长度
//    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
//    long long fileLength = [resp.allHeaderFields[@"Content-Length"] longLongValue];
    
    // 更简单的方式拿到长度;
    self.totalLength = response.expectedContentLength;
}

/**
 *  2.当接收到服务器返回的实体数据时调用（具体内容，这个方法可能会被调用多次）
 *
 *  @param data       这次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
#warning 文件多大， 内存就占多大， 不可行;
    // 拼接数据
    [self.fileData appendData:data];
    
    // 设置进度值 ; 接收到一点就设置一下;
    // 0 ~ 1
//    self.progressView.progress = (double)self.fileData.length / self.totalLength;
#warning 不能整数除整数， 否则一直是0
    self.circleView.progress = (double)self.fileData.length / self.totalLength;
}

/**
 *  3.加载完毕后调用（服务器的数据已经完全返回后）
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    // 拼接文件路径 ;
#warning documents里面要备份的， 不要放太大文件 ； tmp是随时可能被干掉的; 所以放cache中
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [cache stringByAppendingPathComponent:@"videos.zip"];
    
    // 写到沙盒中
#warning 文件多大， 内存就占多大， 不可行;
    [self.fileData writeToFile:file atomically:YES];
}

@end
