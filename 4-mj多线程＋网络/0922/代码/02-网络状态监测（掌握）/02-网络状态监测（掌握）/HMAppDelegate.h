//
//  HMAppDelegate.h
//  02-网络状态监测（掌握）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 之前讲网络数据安全， 传输就是加密;
 
 还有本地数据安全， 存沙盒中; 比如说单机游戏;
 // 越狱了， 能改手机里面所有东西，就完蛋了; 
 
 代码安全： 反编译；
 // 不过现在ios的反编译效果不是很好; 反编译出来的都是c语言的; 而且全是运行时的底层代码， 可读性非常差; 但是最起码能知道里面用了哪些框架; 
 // “逆向工程” 就是这么个东西 ； 有本书叫 "ios逆向工程"
 // 解决方案： 混淆代码； 发布之前对代码进行混淆 ;
 // 混淆都适用工具， 不可能是手动混淆的。
 
 
 // 网络请求缓存： 现在基本不实用； 因为服务器端的东西经常在变；
 // 现在缓存基本就是对图片类的东西;
 
 
 // 监控用户网络状态: 苹果自带的不太好用， 但是要会用； 后面有简单的; 
 
 
 
 */
