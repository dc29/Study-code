//
//  HMAppDelegate.h
//  01-cell图片下载（了解）
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 可以包装成一个导航控制器;
 
 // 数组懒加载； cell写法和以前基本一样；只不过这里没封装， 但是图片显示不一样， 今天图片是从网络获取的;
 
 // 图片错乱的问题； 用刷新表格解决； 重要！这么做有性能问题， 每下载完就reload， 其实刷新对应的那一行就可以了。 
 // 关注重点： cell再变， 但是图片对应的行号没变。
 
 // 具体流程仔细看ppt
 
 */
