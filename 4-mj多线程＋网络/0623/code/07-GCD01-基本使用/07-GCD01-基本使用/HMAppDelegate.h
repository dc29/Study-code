//
//  HMAppDelegate.h
//  07-GCD01-基本使用
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end


/*
 
 GCD是在一个libdispatch库中， 但是ios程序默认就会加载。
 // sync 同步， 是指在当前线程中执行;
 // async异步， 是指在另开的一条线程中执行;
 
 
 */