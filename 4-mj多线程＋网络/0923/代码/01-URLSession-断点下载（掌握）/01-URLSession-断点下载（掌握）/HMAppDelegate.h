//
//  HMAppDelegate.h
//  01-URLSession-断点下载（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 
 利用url session下载不耗内存 ； 是边下载边写沙盒 ； 下载进度靠代理；
 // ios6以前不能用
 
 // 今天是讲断点下载; 之前断点利用range; 
 // 用真机下载; 
 
 
 // itools可以看手机沙盒中的文件， 可以使用airplay; 
 
 */
