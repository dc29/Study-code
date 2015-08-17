//
//  AppDelegate.h
//  15-01-0408-window
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 ua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


// 再来一个窗口， 演示可以创建多个窗口
@property(nonatomic, strong) UIWindow *window2;
@end

