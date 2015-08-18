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
 1. ios中， gif直接使用imagenamed加载是不会播放的;
 // 需要使用imageio ； 
 
 // sdwebimage底层就集成了imageio框架来处理gif的;
 
 // sdwebimage默认的disk缓存时间是多少？面试被问过； 是1个星期;
 // 最大缓存大小？ 这个没有给值；
 // 如何设置？ 通过mgr.imagecache拿到去做操作;
 
 // sdwebimage底层是如何实现的？ 跟之前自己写的下载的ppt中的内容差不多;
 
 */
