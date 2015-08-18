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
 自定义operation就是:
 把opreation相关的操作封装起来； 不让外界看到
 
 // 新建类要继承nsoperation; 
 
 // 一个operation被添加到queue中， 他内部会自动调用operation中的main方法;
 // 注意点: 需要自己创建自动释放池; 
 // 注意子线程中， 做完耗时操作， 就要判断自己是否被取消了， 被cancel了就不要再回到主线程了;
 
 */