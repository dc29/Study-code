//
//  HMViewController.m
//  07-UIWebView01-基本使用（了解）
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置背景色， 要设置里面的SCROLL VIEW的背景色; 
    self.webView.scrollView.backgroundColor = [UIColor redColor];
    
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos/minion_01.mp4"];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"02-HTTP" withExtension:@"pptx"];
    
    // HTML5
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"salary" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 根据请求去加载对应的资源
    [self.webView loadRequest:request];
    
    // 伸缩页面到填充整个webView ; 不设置这个， PPT不能完全显示; 边界会有问题;
    self.webView.scalesPageToFit = YES;
}

@end
