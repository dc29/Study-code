//
//  HMApp.m
//  01-cell图片下载（了解）
//
//  Created by Seven on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMApp.h"

@implementation HMApp

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
