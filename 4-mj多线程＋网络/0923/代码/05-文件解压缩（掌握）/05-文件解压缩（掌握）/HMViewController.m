//
//  HMViewController.m
//  05-文件解压缩（掌握）
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "SSZipArchive.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images.zip"];
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [SSZipArchive unzipFileAtPath:location.path toDestination:caches];
    }];
    
    // 必须有这个; 
    [task resume];
}

@end
