//
//  HMViewController.m
//  02-ASI01-基本使用（了解）
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "ASIHTTPRequest.h"

@interface HMViewController () <ASIHTTPRequestDelegate>
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
    [self asynGet];
}

/**
 *  异步的GET请求
 */
- (void)asynGet
{
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    
    // 2.创建一个请求对象
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 15; // 15秒后服务器还没有响应，就算超时
    // 设置代理
    request.delegate = self;
    
    // 3.开始请求
    [request startAsynchronous];
    
    self.request = request;
}

- (void)dealloc
{
    // 这句代码为了防止：控制器销毁了，request还回来调用控制器的代理方法，引发野指针
    [self.request clearDelegatesAndCancel];
}

#pragma mark - ASIHTTPRequestDelegate
/**
 *  1.开始发送请求
 */
- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"requestStarted");
}
/**
 *  2.接收到服务器的响应头信息
 */
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"didReceiveResponseHeaders");
}
/**
 *  3.接收到服务器的实体数据（具体数据）
 *  只要实现了这个代理方法，responseData\responseString就没有值
 */
//- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
//{
//    NSLog(@"didReceiveData-%@", data);
//}
/**
 *  4.服务器的响应数据接收完毕
 */
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished--%@", [request responseData]);
}
/**
 *  5.请求失败
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"requestFailed");
}


/**
 *  同步的GET请求
 */
- (void)synGet
{
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    
    // 2.创建一个请求对象
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 15; // 15秒后服务器还没有响应，就算超时
    
    // 3.开始请求(这行代码会卡主，等待服务器给数据)
    [request startSynchronous];
    
    // 4.请求完毕
    NSError *error = [request error];
    if (error) {
        NSLog(@"请求失败---%@", error);
    } else {
        NSData *data = [request responseData];
        //        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSString *str = [request responseString];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"请求成功---%@", dict);
    }
}

@end
