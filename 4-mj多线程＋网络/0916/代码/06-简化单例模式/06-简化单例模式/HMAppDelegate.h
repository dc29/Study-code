//
//  HMAppDelegate.h
//  06-简化单例模式
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 
 多个对象都需要设计成单例的时候，很麻烦， 所以需要简化一下; 
 
 */
