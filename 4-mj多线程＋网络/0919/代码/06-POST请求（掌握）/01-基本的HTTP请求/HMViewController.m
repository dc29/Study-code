//
//  HMViewController.m
//  01-基本的HTTP请求
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "MBProgressHUD+MJ.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)login;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)login {
    // 1.用户名
    NSString *usernameText = self.username.text;
    if (usernameText.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    
    // 2.密码
    NSString *pwdText = self.pwd.text;
    if (pwdText.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    
#warning 为了点击登陆后， 网速慢， 用户等待的时候不应该让所有东西被点；
    // 增加蒙板
    [MBProgressHUD showMessage:@"正在拼命登录中...."];
    
    // 3.发送用户名和密码给服务器(走HTTP协议)
    // 创建一个URL ： 请求路径
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
#warning url不能包含中文， 需要转码; 浏览器上为什么行？ 因为浏览器给自动转码了;

    // 创建一个请求
#warning 想改变请求方式， 必须创建一个可变的请求;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 5秒后算请求超时（默认60s超时）
    request.timeoutInterval = 15;
    
    request.HTTPMethod = @"POST";
    // 设置请求体
    NSString *param = [NSString stringWithFormat:@"username=%@&pwd=%@", usernameText, pwdText];
    // NSString --> NSData
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求头信息
    [request setValue:@"iPhone 6" forHTTPHeaderField:@"User-Agent"];
    
    // 发送一个同步请求(在主线程发送请求)
    // queue ：存放completionHandler这个任务
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         // 隐藏蒙板
         [MBProgressHUD hideHUD]; // 框架有问题， mj自己改了一下;
         
         
         // 响应的东西在response中;
#warning 文件下载才会用到响应头中的东西; 暂时理解就可以了。
//         NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response; // 需要强转成它的真实类型， 才能拿到属性;
//         NSString *msg = [NSHTTPURLResponse localizedStringForStatusCode:resp.statusCode];
//         NSLog(@"%d %@ %@", resp.statusCode, msg, resp.allHeaderFields);
     
        // 这个block会在请求完毕的时候自动调用
        if (connectionError || data == nil) { // 一般请求超时就会来到这
            [MBProgressHUD showError:@"请求失败"];
            return;
        }
        
        // 解析服务器返回的JSON数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *error = dict[@"error"];
        if (error) {
            // {"error":"用户名不存在"}
            // {"error":"密码不正确"}
            [MBProgressHUD showError:error];
        } else {
            // {"success":"登录成功"}
            NSString *success = dict[@"success"];
            [MBProgressHUD showSuccess:success];
        }
     }];
}
@end
