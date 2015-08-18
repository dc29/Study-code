//
//  HMAppDelegate.h
//  07-AFN02-文件上传
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 
 AFN的SUCCESS和FAILURE是默认在主线程操作的; 
 
 // POST想上传文件必须使用带constructingBodyWithBlock的这个POST方法 ； 不带这个的只能做普通的POST请求; 
 
 */
