//
//  HMAppDelegate.h
//  05-NSThread03-线程同步
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 多线程安全问题， 加锁（同一时间只有一个线程可以去操作这个变量, 互斥锁/同步锁
 
 */
