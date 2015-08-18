//
//  HMAppDelegate.h
//  01-基本的HTTP请求
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 http请求有8种方法， 最常用的就是下面的2个;
 
 get方法： 所有参数拼接在url后面， 做登陆是不合适的;
 post: 参数不放在url后面， 是放在请求体中; 
 
 // 登陆不要用get， 因为登陆的信息都会保存在手机的日志中; 如果手机被黑了就完蛋了。
 
 
 */
