//
//  HMApp.h
//  01-cell图片下载（了解）
//
//  Created by Seven on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMApp : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *download;

+ (instancetype)appWithDict:(NSDictionary *)dict;

@end
