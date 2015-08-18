//
//  HMViewController.m
//  02-文件上传（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"



#define HMFileBoundary @"heima"  // 这个就是标记
#define HMNewLien @"\r\n"
#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self upload];
}

/*
 参数1
 参数2
 结束标记
 */

/*
 * 文件参数
 heima
 Content-Disposition: form-data; name="参数名"; filename="文件名"
 Content-Type: 文件类型（MIMEType）
 
 文件具体数据
 
 * 非文件参数
 heima
 Content-Disposition: form-data; name="参数名"
 
 参数值
 */

- (void)upload
{
    // 1.请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/upload"];
    
    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3.设置请求体
    NSMutableData *body = [NSMutableData data];
    
#warning 参数中的“BODUNDARY”比请求头中多--
    // 3.1.文件参数
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(@"Content-Disposition: form-data; name=\"file\"; filename=\"test123.png\"")];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(@"Content-Type: image/png")];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(HMNewLien)];
    UIImage *image = [UIImage imageNamed:@"minion_03"];
    NSData *imageData = UIImagePNGRepresentation(image); // IAMGE --> DATA
    [body appendData:imageData];
    [body appendData:HMEncode(HMNewLien)];
    
    // 3.2.用户名参数
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(@"Content-Disposition: form-data; name=\"username\"")];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(HMNewLien)];
    [body appendData:HMEncode(@"张三")];
    [body appendData:HMEncode(HMNewLien)];
    
    // 3.3.结束标记
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMNewLien)];
    
    request.HTTPBody = body;
    
    // 4.设置请求头(告诉服务器这次传给你的是文件数据，告诉服务器现在发送的是一个文件上传请求)
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", HMFileBoundary]; // 这个是固定写法;
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // 5.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
    }];
}
@end
