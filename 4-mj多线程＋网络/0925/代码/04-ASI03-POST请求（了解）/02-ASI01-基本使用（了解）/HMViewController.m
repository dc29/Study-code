//
//  HMViewController.m
//  02-ASI01-基本使用（了解）
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "ASIFormDataRequest.h"

// 使用ASIFormDataRequest, 默认发送的就是POST请求

@interface HMViewController ()
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
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    
    // 2.创建一个请求对象
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    // 3.设置请求参数(建议使用setPostValue多一点)
    [request setPostValue:@"123" forKey:@"username"];
    [request setPostValue:@"123" forKey:@"pwd"];
    
    // 4.开始请求
    [request startAsynchronous];
    
    // 5.设置监听方法
    __weak typeof(request) weakRequest = request;
    [request setCompletionBlock:^{
        NSLog(@"请求完毕--%@", [weakRequest responseString]);
    }];
}
@end
