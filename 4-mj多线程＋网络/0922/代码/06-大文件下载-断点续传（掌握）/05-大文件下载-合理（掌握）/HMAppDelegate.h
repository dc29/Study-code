//
//  HMAppDelegate.h
//  05-大文件下载-合理（掌握）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 真实环境， 影响网络质量有很多因素
 1. 为了用户体验， 需要有进度条;
 2. 需要断点续传下载; 
 
 // 给按钮设图片， 最好用custom. 不管是背景还是别的; 
 
 
 // 继续下载通过http的range属性; 500-  是500字节以后的
 
 // 要解决再继续下载发请求， 重新下载的问题; 
 
 // self.currentLength这个应该存沙盒的， 下次继续从这个地方下载， 自己完善; 
 
 // 多线程断点续传比较麻烦， 今天主要讲解下思路:
 // 刚刚是单线程下载， 慢
 // 多线程： 假如4条线程下载800m， 把800m切割， 分别从不同的位置开始； 然后最后完成时拼在一起;
 // 完成后如何合并？
    // 一定要先创建一个800m的文件; 不能先来0字节的；
 
 
 
 
 */
