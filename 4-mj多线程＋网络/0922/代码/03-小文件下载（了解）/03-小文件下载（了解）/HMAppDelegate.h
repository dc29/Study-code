//
//  HMAppDelegate.h
//  03-小文件下载（了解）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 
 小文件下载比较简单; 
 // 文件下载一般都是get请求; 
 
 // 为什么说这段代码只能用于小文件; 
 // 因为 
 1: 下一半死机就完了， 需要重新下;
 2: 并且也不能监听下载进度;
 3: 真是大文件， 内存就爆了; 
 
 */
