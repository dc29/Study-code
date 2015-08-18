//
//  HMViewController.m
//  02-一次性代码（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "HMImageDownloader.h"

@interface HMViewController ()
//@property (nonatomic, strong) HMImageDownloader *downloader;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.downloader = [[HMImageDownloader alloc] init];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"----touchesBegan");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"----once");
        HMImageDownloader *downloader = [[HMImageDownloader alloc] init];
        [downloader download];
    });
}

@end
