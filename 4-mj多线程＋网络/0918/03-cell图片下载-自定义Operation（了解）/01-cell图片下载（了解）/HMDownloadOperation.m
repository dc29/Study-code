//
//  HMDownloadOperation.m
//  01-cell图片下载（了解）
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMDownloadOperation.h"

@implementation HMDownloadOperation

// 一个operation被添加到queue中， 他内部会自动调用operation中的main方法;
- (void)main
{
#warning 需要自己写自动释放池;
    @autoreleasepool {
        if (self.isCancelled) return;
        
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url]; // 下载
        UIImage *image = [UIImage imageWithData:data]; // NSData -> UIImage
        
        if (self.isCancelled) return;
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishDownload:)]) {
                [self.delegate downloadOperation:self didFinishDownload:image];
            }
        }];
    }
}
@end
