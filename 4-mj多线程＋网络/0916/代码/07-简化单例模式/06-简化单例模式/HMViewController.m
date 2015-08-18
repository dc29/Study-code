//
//  HMViewController.m
//  06-简化单例模式
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "HMMusicTool.h"
#import "HMMovieTool.h"
#import "HMDataTool.h"

#import "HMPerson.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    HMMusicTool *tool1 = [HMMusicTool sharedMusicTool];
//    HMMusicTool *tool2 = [HMMusicTool sharedMusicTool];
//
//    HMMovieTool *tool3 = [HMMovieTool sharedMovieTool];
//    HMMovieTool *tool4 = [HMMovieTool sharedMovieTool];
//    
//    HMDataTool *tool5 = [HMDataTool sharedDataTool];
//    HMDataTool *tool6 = [HMDataTool sharedDataTool];
//
//    NSLog(@"%@ %@", tool5, tool6);
    
    HMPerson *p = [[HMPerson alloc] init];
    
#if __has_feature(objc_arc)
    // 编译器是ARC环境
#else
    // 编译器是MRC环境
    [p release];
#endif
}

@end
