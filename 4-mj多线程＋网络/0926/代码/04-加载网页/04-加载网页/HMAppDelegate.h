//
//  HMAppDelegate.h
//  04-加载网页
//
//  Created by apple on 14-9-26.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 电商类商品详情， 和 新闻类新闻详情 一般用网页来搞；
 网页搞这些东西很快， 而且方便; 图文混排比较轻松; 
 
 一般是原生和H5结合一起做APP ;
 对前端知识不太熟悉， 写的慢怎么办？ 用 前端框架 ；
 比如:
    1. BOOTSTRAP ， TWITTER公司的; 可以创建响应式网站; 
    // 找资料： 去BOOTSTRAP中文网;
    // 使用方法： 下载后， 将解压缩的文件拖进WEBSTORM中
    // 一般开发者会准备2个CSS版本； 开发时用一个能看懂的， 然后上线放一个最小版， 就是为了减少代码的数量； 都放在一行， 去掉那些空格之类的; 
    // 然后LINK REL=
    // 然后在代码中设置CSS CLASS之类的就有不同效果了;
 
    // BOOTSTRAP很NB的字体文件; 是图片字体; 就是看到的图片实际是文字; 
    // 以前想搞图片， 需要美工切一张； 现在直接它能凭空产生一张图片;
 
 
 
 // 很多H5框架就是把JS封装成很NB的效果 ； 所以想学好H5， 必须把JS搞定; 
 // JS是浏览器客户端的脚本语言; 解释型的; 
 
 
 */
