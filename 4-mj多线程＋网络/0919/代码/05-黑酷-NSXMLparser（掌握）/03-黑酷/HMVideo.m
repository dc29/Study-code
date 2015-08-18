//
//  HMVideo.m
//  03-黑酷
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMVideo.h"

@implementation HMVideo
+ (instancetype)videoWithDict:(NSDictionary *)dict
{
    HMVideo *video = [[self alloc] init];
    
    // 使用前提：要求字典中的所有key，都能在模型中找到对应的属性
    [video setValuesForKeysWithDictionary:dict];
    
    // reason: '[<HMVideo 0xb88e170> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key id.'
    return video;
}
@end
