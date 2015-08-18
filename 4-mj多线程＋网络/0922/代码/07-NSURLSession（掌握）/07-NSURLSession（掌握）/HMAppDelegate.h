//
//  HMAppDelegate.h
//  07-NSURLSession（掌握）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 nsurlsession 是从ios7开始的， apple的目的为了取代nsurlconnection ; 
 // 也支持文件下载， 上传;
 // 一般的服务器是不支持apple的uploadtask的， 所以我们一般用datatask, downloadtask..
 
 
 
 
 */
