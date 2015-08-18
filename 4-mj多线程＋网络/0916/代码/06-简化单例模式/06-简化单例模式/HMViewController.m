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

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HMMusicTool *tool1 = [HMMusicTool sharedInstance];
    HMMusicTool *tool2 = [HMMusicTool sharedInstance];
    
    HMMovieTool *tool3 = [HMMovieTool sharedInstance];
    HMMovieTool *tool4 = [HMMovieTool sharedInstance];
    
    NSLog(@"%@ %@ %@ %@", tool1, tool2, tool3, tool4);
}

@end
