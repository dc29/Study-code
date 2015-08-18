//
//  HMViewController.m
//  01-AFN03-监控网络状态
//
//  Created by apple on 14-9-25.
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
	// Do any additional setup after loading the view, typically from a nib.
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) { // 设置网络状态改变的BLOCK;
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    
    // 开始监控 ； 必须执行这个才能开始监控;
    [mgr startMonitoring];
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
