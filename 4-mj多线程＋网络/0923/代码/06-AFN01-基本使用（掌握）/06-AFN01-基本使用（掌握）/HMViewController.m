//
//  HMViewController.m
//  06-AFN01-基本使用（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "AFNetworking.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self postJSON];
}

- (void)getSession
{
    // AFHTTPSessionManager 对 NSURLSession 的封装
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

/**
 *  利用AFN发送一个POST请求，服务器返回的JSON数据
 */
- (void)postJSON
{
    // AFHTTPRequestOperationManager 对 NSURLConnection的封装
    
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"哈哈哈";
    params[@"pwd"] = @"123";
    
    // 3.发送一个GET请求
    NSString *url = @"http://localhost:8080/MJServer/login";
    [mgr POST:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 请求成功的时候调用这个block
         NSLog(@"请求成功---%@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败");
     }];
}

/**
 *  利用AFN发送一个GET请求，服务器返回的JSON数据，让AFN直接返回data
 */
- (void)getData
{
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 声明：不要对服务器返回的数据进行解析，直接返回data即可
    // 如果是文件下载，肯定是用这个
    // responseObject的类型是NSData
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"哈哈哈";
    params[@"pwd"] = @"123";
    
    // 3.发送一个GET请求
    NSString *url = @"http://localhost:8080/MJServer/login";
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 请求成功的时候调用这个block
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
         
         NSLog(@"%@", dict);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败");
     }];
}

/**
 *  利用AFN发送一个GET请求，服务器返回的XML数据
 */
- (void)getXML
{
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 声明：等会服务器返回的是XML数据
    // responseObject的类型是NSXMLParser
    mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"哈哈哈";
    params[@"pwd"] = @"123";
    params[@"type"] = @"XML";
    
    // 3.发送一个GET请求
    NSString *url = @"http://localhost:8080/MJServer/login";
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 请求成功的时候调用这个block
         NSLog(@"请求成功--%@", responseObject);
         
#warning 解析的代码需要自己实现， AFN不会解析;
//         responseObject.delegate = self;
//         [responseObject parse];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败");
     }];
}

/**
 *  利用AFN发送一个GET请求，服务器返回的JSON数据
 */
- (void)getJSON
{
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
#warning 这就是为什么返回的数据为什么会转成字典;
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer]; // 声明一下：服务器返回的是JSON数据  ; 不写也可以， 是因为是默认的;
    // responseObject的类型是NSDictionary或者NSArray
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"哈哈哈";
    params[@"pwd"] = @"123";
    
    // 3.发送一个GET请求
    NSString *url = @"http://localhost:8080/MJServer/login";
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 请求成功的时候调用这个block
         NSLog(@"请求成功---%@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败");
     }];
}

@end
