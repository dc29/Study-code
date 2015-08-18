//
//  HMApp.m
//  01-cell图片下载（了解）
//
//  Created by 周大伟 on 15/5/28.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMApp.h"

@implementation HMApp

// 实用kvc ； 使用有前提， 字典里面key 和 plist中完全一样;
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    HMApp *app = [[self alloc] init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
    
}
@end
