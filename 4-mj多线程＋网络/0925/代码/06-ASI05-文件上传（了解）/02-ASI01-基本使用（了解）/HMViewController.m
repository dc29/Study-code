//
//  HMViewController.m
//  02-ASI01-基本使用（了解）
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    ASINetworkQueue *queue = [ASINetworkQueue queue];
//    queue.shouldCancelAllRequestsOnFailure = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/upload"];
    
    // 2.创建一个请求对象
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    // 3.设置请求参数
    [request setPostValue:@"zhangsan" forKey:@"username"];
    [request setPostValue:@"123" forKey:@"pwd"];
    [request setPostValue:@"28" forKey:@"age"];
    [request setPostValue:@"1.89" forKey:@"height"];
    
    // 设置文件参数
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    // 如果知道文件路径，最好就用这个方法（因为简单）
    // ASI内部会自动识别文件的MIMEType
    [request setFile:file forKey:@"file"];
//    [request setFile:file withFileName:@"basic.pptx" andContentType:@"application/vnd.openxmlformats-officedocument.presentationml.presentation" forKey:@"file"];
    
    // 如果文件数据是动态产生的，就用这个方法(比如刚拍照完获得的图片数据)
//    [request setData:<#(id)#> withFileName:<#(NSString *)#> andContentType:<#(NSString *)#> forKey:<#(NSString *)#>];
    
    // 4.设置监听上传进度的代理
    request.uploadProgressDelegate = self.progressView;
    
    // 5.开始请求
    [request startAsynchronous];
    
    // 6.监听完毕
    __weak typeof(request) weakRequest = request;
    [request setCompletionBlock:^{
        NSLog(@"%@", [weakRequest responseString]);
    }];
}
@end
