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
 
 沙盒中， documents是会备份的; 这里不要放太大的文件; preference也会被itunes会备份
 图片一般放lib-->caches中; 这个是不会被备份的;
 tmp不安全， 系统会随机清除掉
 
 */
