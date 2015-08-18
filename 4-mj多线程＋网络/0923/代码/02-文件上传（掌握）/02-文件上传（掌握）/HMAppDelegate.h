//
//  HMAppDelegate.h
//  02-文件上传（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 
 这个上传比较复杂， 过一遍，流程必须掌握;
 
 多种方式：URLSESSION, URLCONNection都可以;
 1. HTTP请求； 肯定是POST请求;
 // 技巧： 可以用火狐的FIREBUG来看下上传的是什么东西 ; 普通的POST请求， 请求体很简单； 但是上传就复杂了;
 // FIREBUG看见的请求体， 里面的格式必须遵循， 一个空格都不能少;
 
 
 
 // 文件上传请求体包含的内容：
 看总结！
 
 */
