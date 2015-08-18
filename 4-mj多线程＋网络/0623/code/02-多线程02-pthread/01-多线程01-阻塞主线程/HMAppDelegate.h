//
//  HMAppDelegate.h
//  01-多线程01-阻塞主线程
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
/*
 // 如何开线程？
 1. posix thread 古老的技术， 纯c语言的， 是一套通用的多线程技术. 需要程序员管理线程的生命周期; 使用难度大；ios中几乎不用， 底层代码可能会看到， 比如智能家居应用
 2. nsthread; oc的， 更加面向对象； 偶尔使用.
 3. gcd非常nb的技术；为了替代nsthread。能充分利用设备的多核. c语言的。 自动管理. 经常使用
 4. nsoperation, 底层是基于gcd的， 比gcd多了一些更简单的功能。更加面向对象. 经常使用。
 
 // 更改项目名称， 一个是左上角改下， 还有一个是manage scheme。
 
 
 
 
 */