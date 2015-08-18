//
//  HMAppDelegate.h
//  06-网易新闻详情（掌握）
//
//  Created by apple on 14-9-29.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end


/*想要截获手机数据： 需要将手机连接到电脑发射出的WIFI， 然后在电脑上使用CHARLES
 
 网易新闻HTML有个细节： 就是图片插到什么位置， 它给了占位符; 在IMG字典里面的REF选项就是;
 
 
 
 
 
 */