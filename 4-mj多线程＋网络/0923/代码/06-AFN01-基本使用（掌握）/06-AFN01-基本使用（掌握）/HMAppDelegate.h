//
//  HMAppDelegate.h
//  06-AFN01-基本使用（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 
 AFN是重点， ASI为了了解下应付面试和旧项目; 
 
 // ASI效率高是因为底层使用的CFNETWORK ； 使用起来比较麻烦;
 // AFN是NSURLCONNECTION 然后才CFNETWORK， 绕了一层;  但是无伤大雅； 使用方便
 
 // GITHUB上星星最多的是BOOTSTRAP， TWITTER公司的产品， 但是不是用在IOS上的， 是前段框架, CSS。。。
 
 */
