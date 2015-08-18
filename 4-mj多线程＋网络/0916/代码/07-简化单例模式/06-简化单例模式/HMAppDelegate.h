//
//  HMAppDelegate.h
//  06-简化单例模式
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 arc和非arc ， 要用到一份代码的话， 需要判断， 需要用到条件编译;
 // 根据条件有选择性的对某一段代码进行编译;
 
 注意一个问题 #在宏里面是有特殊含义的。
 
 */
