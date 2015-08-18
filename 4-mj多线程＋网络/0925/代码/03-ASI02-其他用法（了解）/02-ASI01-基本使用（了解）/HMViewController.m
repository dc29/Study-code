//
//  HMViewController.m
//  02-ASI01-基本使用（了解）
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "ASIHTTPRequest.h"

/**
 监听ASI的请求
 1.成为代理，遵守ASIHTTPRequestDelegate协议，实现协议中的代理方法
 request.delegate = self;
 - (void)requestStarted:(ASIHTTPRequest *)request;
 - (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
 - (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data;
 - (void)requestFinished:(ASIHTTPRequest *)request;
 - (void)requestFailed:(ASIHTTPRequest *)request;
 
 2.成为代理，不遵守ASIHTTPRequestDelegate协议，自定义代理方法
 request.delegate = self;
 [request setDidStartSelector:@selector(start:)];
 [request setDidFinishSelector:@selector(finish:)];
 
 3.设置block
 [request setStartedBlock:^{
    NSLog(@"setStartedBlock");
 }];
 [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
    NSLog(@"setHeadersReceivedBlock--%@", responseHeaders);
 }];
 [request setDataReceivedBlock:^(NSData *data) {
    NSLog(@"setDataReceivedBlock--%@", data);
 }];
 [request setCompletionBlock:^{
    NSLog(@"setCompletionBlock");
 }];
 [request setFailedBlock:^{
    NSLog(@"setFailedBlock");
 }];
 */

@interface HMViewController () <ASIHTTPRequestDelegate>
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    
    // 2.创建一个请求对象
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    // 3.开始请求
    [request startAsynchronous];
    
    // 4.设置监听方法
    request.delegate = self;
    [request setDidStartSelector:@selector(start:)];
    [request setDidFinishSelector:@selector(finish:)];
}

- (void)start:(ASIHTTPRequest *)request
{
    NSLog(@"start--%@", request);
}

- (void)finish:(ASIHTTPRequest *)request {
    NSLog(@"finish--%d %@ %@", [request responseStatusCode], [request responseStatusMessage], [request responseData]);
}

- (void)asyncBlock
{
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    
    // 2.创建一个请求对象
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    // 如果同时设置了block和实现了代理方法，请求过程中，block和代理方法都会调用，
    // 一般的调用顺序：代理方法 > block
    //    request.delegate = self;
    
    // 3.开始请求
    [request startAsynchronous];
    
    // 4.设置block监听
    [request setStartedBlock:^{
        NSLog(@"setStartedBlock");
    }];
    [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
        NSLog(@"setHeadersReceivedBlock--%@", responseHeaders);
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        NSLog(@"setDataReceivedBlock--%@", data);
        
    }];
    [request setCompletionBlock:^{
        NSLog(@"setCompletionBlock");
    }];
    [request setFailedBlock:^{
        NSLog(@"setFailedBlock");
    }];
}

//- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
//{
//    NSLog(@"didReceiveData--%@", data);
//}
//
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSLog(@"requestFinished");
//}
@end
