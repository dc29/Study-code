//
//  HMAppDelegate.h
//  03-黑酷
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 json比xml数据量小很多; 
 
 // 动态库要自己添加 ； 并且要告诉header search paths(就是告诉他头文件去哪里找) ； 看ppt
 // other link flags : 是告诉连接的时候把这个动态库链接进来。
 // gdata那文件是非arc的 ， 需要告诉编译器他是非arc的; 在build - phases中 compile sources 中找到那个文件。-fno-objc-arc
 
 
 
 */