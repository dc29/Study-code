//
//  HMApp.h
//  01-cell图片下载（了解）
//
//  Created by 周大伟 on 15/5/28.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMApp : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *icon;

+(instancetype) appWithDict:(NSDictionary *)dict;

@end
