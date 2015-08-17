//
//  AppDelegate.m
//  15-01-0408-window
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 ua. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1. 创建窗口
    UIWindow *window = [[UIWindow alloc] init];
    // 一般windw的frame就是屏幕的大小。
    window.frame = [UIScreen mainScreen].bounds;
    
    // 2. 设置window的颜色
    window.backgroundColor = [UIColor redColor];
    
    // 3. show
    // 只有这一句不行， 还是不显示， 因为window被销毁了， 因为是局部变量; 所以属性中是strong
    [window makeKeyAndVisible];
    // makekey， 让window成为keywindow(主窗口), visible, 并且可见; 还要有下面这一句。
    self.window = window;
   
    
    // 成为主窗口有什么用呢？ 不管有多少窗口， 只能有一个窗口成为主窗口。
    UIWindow *window2 = [[UIWindow alloc] init];
    window2.backgroundColor = [UIColor yellowColor];
    window2.frame = CGRectMake(100, 100, 200, 200);
    [window2 makeKeyAndVisible];
    self.window2 = window2;
    // 现在window2是主窗口
    
    
    
    UITextField *tf2 = [[UITextField alloc] init];
    tf2.frame = CGRectMake(0, 0, 50, 50);
    // 不加这个样式是不会显示的
    tf2.borderStyle = UITextBorderStyleRoundedRect;
    [self.window2 addSubview:tf2];
    
    
    // 窗口多的时候，如何拿到主窗口; 并且验证一下谁是主窗口。
    // 看内存地址就ok了。
    // [UIApplication sharedApplication].keyWindow; 是拿到主窗口
    // NSLog(@"%p,%p,%p", window, window2, [UIApplication sharedApplication].keyWindow);
    
    // 适配很麻烦， 4.3的东西还得写release。
    // 开发中， 如果一个文本框不能输入东西， 首先要想一下， 这个窗口是不是主窗口。 找bug得方法。
    
    // 拿到所有窗口； windows是一个数组。
    // [UIApplication sharedApplication].windows;
    
    // window makeKeyWindow
    // window makeKeyAndVisible
    // 一个可见， 一个不可见。
    
    
    // 叫出得键盘也在一个全新得window中。
    // 并且键盘再一个320 480得大窗口中。
    // 为什么说这个呢》？ 因为以后如果想改键盘上得东西， 就得拿到键盘所再得窗口。然后就可以拿到里面得按钮， 修改里面得文字。
    // 如何验证？ 再加一个按钮， 点击得时候叫键盘， 然后打印下有多少个窗口
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.window2 addSubview:btn];
    

    return YES;
}



- (void) btnclick
{
    NSLog(@"%@", [UIApplication sharedApplication].windows);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
