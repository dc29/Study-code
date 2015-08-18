//
//  HMAppDelegate.h
//  04-大文件下载-不合理（了解）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 这种是比较合理的下载; 
 data需要连接成一个文件。
 
 // 可以用apple自带的直线进度条;
 // 圆形的进度条主要是quartz2d绘图， 自己不愿意写， 也可以去网上找;
 // mj代码里面的就是随便在code4app上找的一个; 
 
 */
