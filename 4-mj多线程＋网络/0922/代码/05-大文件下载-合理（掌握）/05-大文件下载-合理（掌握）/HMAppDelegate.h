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
 
 这种是比较合理的方式: 需要掌握
 
 1. 之前的做法不合理， 内存会完蛋； 需要优化内存
 2. 思路： 应该是下载一点写一点
 3. 需要现在沙盒中先创建一个和文件大小一样的空文件; 想想迅雷; 
 // 挪到文件最后一个位置， 就不用上来就创建一个和服务器端文件一样大的文件了。
 // [self.writeHandle seekToEndOfFile];
 
 
 
 */
