//
//  HMSoundTool.m
//  03-单例模式-Singleton（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//  饿汉式

#import "HMSoundTool.h"

@implementation HMSoundTool
static id _instance;

/**
 *  当类加载到OC运行时环境中（内存），就会调用一次（一个类只会加载1次）
 */
#warning load方法， 上来就创建；一个类加载到内存时就会调用. 就不存在多线程问题了;
+ (void)load
{
    _instance = [[self alloc] init];
}



+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (_instance == nil) { // 防止创建多次
        _instance = [super allocWithZone:zone];
    }
    return _instance;
}



+ (instancetype)sharedSoundTool
{
    return _instance;
}



- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

///**
#warning   当第一次使用这个类的时候才会调用
// */
//+ (void)initialize
//{
//    NSLog(@"HMSoundTool---initialize");
//}
@end
